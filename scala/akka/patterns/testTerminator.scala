import akka.actor.{ActorSystem, Actor, Props, ActorRef}
import akka.testkit.{TestKit, ImplicitSender, TestProbe}

class TestWorker(a: ActorRef) extneds Actor {
  overrride def postStop() = a ! self.path.name
}

val terminator  = system.actorOf(Props(new Terminator {
  override def preStart() {
    (1 to 20).foreach { i=>
      //testActor is from TestKit
      context.actorOf(Props(new TestWorker(testActor))) //create children under terminator
    }
  }

  def order(kids: Iterable[ActorRef]) : Iterable[ActorRef] =
    kids.toSeq.sorted.reverse //dummy implementaiton
}))

val probe = TestProbe()

terminator.tell(GetChilren(probe.ref), probe.ref) //send from probe to terminator

probe.expectMsgPF() {
  case Children(kids) => kids.size must be (20)
}

system.stop(probe.ref) //terminator's deathwatch will kick in, and terminate kids in the sequence defined

(1 to 20).reverse.foreach { i =>
    expectMsg() //based on the implementation of postStop(), the message will be sent back to the testActor
}

