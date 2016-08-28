import java.util.concurrent._

/**
 * Created by georgeli on 15-09-21.
 */
object Par {
  //Notice this is java future, not scala future. This is why we HAVE to wrap it in Par
  type Par[A] = ExecutorService => Future[A]

  case class UnitFuture[A](get: A) extends Future[A] {
    def isDone = true
    def get(timeout: Long, units: TimeUnit) = get
    def isCancelled = false
    def cancel(evenIfRunning: Boolean): Boolean = false
  }

  def unit[A](a : A): Par[A] = (es: ExecutorService) => UnitFuture(a)

  def lazyUnit[A] (a : => A): Par[A] = fork(unit(a))

  //Notice fork is call by name, the reason is that the design of fork comes from the requirement of map, which requires lazy eval,
  //and explict fork means as long as fork is lazy eavled, map can be call by value
  def fork[A] (a: => Par[A]) : Par[A] =  es => es.submit(new Callable[A] { //potential deadlock problem with this implementation
    def call = a(es).get
  })


  def map2[A,B,C](a: Par[A], b: Par[B]) (f: (A,B) =>C): Par[C] = (es: ExecutorService) => {
    val aVal = a(es) //Notice we dispatch future here (via fork that params are combined) instead of as param of f, because Future.get is blocking
    val bVal = b(es)
    UnitFuture(f(aVal.get, bVal.get))
  }

  def asyncF[A,B](f: A => B): A => Par[B] = (a: A) => lazyUnit(f(a))

  def sequence[A](ps: List[Par[A]]): Par[List[A]] = ps match {
    case Nil => unit(Nil)
    case head:: tail => map2(head, sequence(tail)) (_ :: _)
  }

  def parMap[A,B](ps: List[A])(f: A => B): Par[List[B]] = fork {//this fork is there so that the call returns immediately
    //also, the async calls will be kicked off by the forked thread
   val listPar = ps.map(asyncF(f(_)))
    sequence(listPar)
  }

  /*
  def parFilter[A](as: List[A])(f: A => Boolean): Par[List[A]] = {
  }
  */

  def equal[A](e: ExecutorService)(p: Par[A], p2: Par[A]): Boolean =
    p(e).get == p2(e).get


  def deadLock = {
    val a = lazyUnit(42 + 1)
    val S = Executors.newFixedThreadPool(1)
    println(Par.equal(S)(a, fork(a)))
  }

  /*
  This deadlocks because fork(a) submits a lazyUnit to es, and lazyUnit submits to es again
  when the lazyUnit submits, that means the first callable is using the es thread, and will be block waiting on get.
  If the submitted a is a UnitFuture, it returns immediately and we are good
  However, if it is lazyFuture, we must wait until another es thread to pick up and execute call inside lazyFuture
  but our main es thread is already blocking => deadlock
   */
}
