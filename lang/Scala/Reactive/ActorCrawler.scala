import akka.actor.Actor
import akka.actor.Props
import akka.event.LoggingReceive
import com.ning.async-http-client
import org.jsoup.Jsoup
import scala.collection.JavaConverters._
/*
 Scenario: Link checker
 given an URL, recursivly download the content, extract links and follow them bound by max depth
 
//model activites as actors
need a receptionist to handle that given URL

need a controller to aggregate result, ensure no duplication

need a getter to do actual heavy lifting

Now design messages
Get(url) to reception
check (url, depth) to controller
get(url) to getter, getter will give back all urls, and a done in the end to controller

note that we choose to include state in message as well
Result(url) from controller to reception

*/

object WebClient{
  val client = new AsyncHttpClient

  //a reactive application is non-blickign & event-driven top to bottom
  def get(url: String) (implicit exec : Executor) = {
    val f = client.prepareGet(url).execute() 
    val p = Promise[String]()
    f.addListener(new Runnerable { //async request
      def run = {
        val response = f.get
        if (response.getStatusCode < 400)
          p.success("val")
        else
          p.failure(BadStatus(response.getStatusCode))
      }
      
    }, exec)
  
    p.future
  }
  
 }

class Getter (url: String, depth : Int) extends Actor {
  val future = WebClient.get(url) 
  future.pipeTo(self) //sends result of future to itself for future processing
    
  def findLinks(body: String) = {
    val document = Jsoup.parse(body, url)
    val links = document.select("a[href]")
    
    for {
      link <- links.iterator(0.asScala)
    }yield link.absUrl("href")
    
  }

  //actors run by dispatchor
  def receive = {
    case body: String =>
      for (link <- findLinks(body))
        context.parent ! Controller.Check(link depth) //parent is the creator of this actor
        stop()_
        case _: Status>Failure => stop()
        case Abort => stop()
  }
  
  def stop() = {
    context.parent ! Done
    context.stop(self)
  }
  
}

class Controller extends Actor {
  var cache = Set.empty[String] //notice we use var on immutable datat structure, because we need to share it with other actors
  var chilren = Set.empty[ActorRef]
  
  context.setReceiveTimeout(10.seconds) //or we can use scheudler, e.g., scheduleronce, thus we will impose an overall 10 sec restriction
  
  def receive = {
    case Check(url, depth) =>
      if (!cache(url) && depth > 0)
        chilren += context.actorOf(props(new Getter(url, depth - 1)))
      
        cache += url
    case Getter.Done =>
      chilren -= sender
      if (chilren.isEmpty) context.parent ! Result(cache)
    
    case ReceiveTimeout => children foreach (_ ! Getter.abort)
  }
  
  
}

//how actor interacts with future
class Cache extends Actor {
  var cache = Map.empty[String, String]
  
  def receive = {
    case Get(url) =>
      if (cache contains url) sender ! cache(url)
      else
        val client = sender
        WebClient get url map (Result(client, url, _)) pipeTo self //do not refer to actor state from code running asyncly
    case Result(client, url, body) =>
      cache  += url -> body
      client ! body
  }
  
}


class Receptionist extends Actor{
  def receive = waiting
  
  val waiting: Receive = {
    case Get(url) => context.become(runNext(Vector(Job(sender, url))))
  }
  
  def running(queue: Vector[Job]): Receive = {
    case Controller.Result(links) =>
    val job = queue.head
    job.client ! Result(job.url, links)
    context.stop(sender) //this one is done for current quest
    context.become(runNext(queue.tail))
    case Get(url) =>//when new request while we are running current one
      context.become(enqueueJob(queue, Job(sender, url)))

  }
  
  case class Job(client: ActorRef, url: String)
  var reqNo = 0
  
  def runNext(queue: Vector[Job]):Receive = {
    reqNo += 1
    if(queue.isEmpty) waiting
    else{
      val controller = context.actorOf(props[Controller], s"c$reqNo")//actor name needs to be unique
      controller ! Controller.Check(queue.head.url, 2)
      running(queue)
    }
  }
  
  def enqueueJob(queue: Vector[Job], job: Job): Receive = {
    //buffer control logic here
  }
}