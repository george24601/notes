import scala.concurrent.ExecutionContext.Impicits.global

val socket = Socket()
val packet : Future[Array[Byte]] = socket.readFromMemory()

val confirmation : Future [Array[Byte]] = packet.flatMap ( p => socket.sendToEurope(p))

def sendToEurope(packet: Array[Byte]) : Fture [Array[Byte]] =
Http(URL, Request(packet))
.filter(response => response.isOK) //how does this work??
.map(response => response.toByteArray) 

//now send the thing twice

val enropeConfirm = sendTo
val usaConfirm = sendTo

enropeConfimr.zip)useConfirm) //when zipping 2 futures, and one of them fails, the zip will fail!!

//so introduce recover and recoverWith

sendTo(europe, packet) recoverWith {
	case europeError => sendTo(usa, packet) recover {
	case usaError => usaerror.getMessage.toByteArray

}
}


def fallbackTo(that: => Future[T]): Future[T] = {
 this recoverWith {
  case _ => that recoverWith { case _ => this}
}

//if that future fails to, take the error of THIS future
}

//awaitable => dont use it in production!

import scala.language. postfixOps

val c = Await.result(confirmation, 2 seconds)


def retry (noTimes: Int) (block: => Future[T]): Future[T] = {
	if (noTimes == 0)
		Future.failed(new Exception("sorry"))
	else
		block fallbackTo {
			retry(noTimes - 1) (block}
		}
}

//recursion is GOTO of functional programming!
//use foldLeft and foldRight
//List(a,b,c).foldLeft(e)(f) = f( f(f(e, a), b), c)
//List(a,b,c).foldRight(e)(f) = f(a, f(b, f(c,e)))

def retry (noTimes: Int) (block: => Future[T]): Future[T] = {
val ns = (1 to noTimes).toList
val attempts = ns.map(_ => () => block) //need this thunk for lazy eval!
val failed = Future.failed(new Exception("boom"))
val result = attemps.foldLeft(failed) 
 ((a, block) => a recoverWith { block()}

result
}

val result = attempts.foldRight(() => failed)
 ((block, a) => () => {block() fallbackTo {a()})
result()

//implicit future

import scala.async.Async._

def retry (noTimes: Int) (block: => Future[T]): Future[T] = {
async {
var i = 0

var reuslt : Try[T] = Failure(new Exception())
while (result.isFaiulre && i < noTimes) {
	result = await (Try{block)}
	i += 1
}

}

result.get
}

def filter(p : T => Boolean) : Future[T] = async {
 val x = await {this}
if(!p(x)) {
	throw new NoSuchElementException()
}else 
x
}

def flatMap[S] (f: T => Future[S]) : Future[S] = async {
val x: T = await {this}
await {f(x)}
}

def filter(pred: T => Boolean) : Future[T] = {

val p = Promise[T] ()

this onComplete {
case Fialure(e) =>
	p.failure(e)
case Success(x) =>
	if(!pred(x)) p.failure(new NoSuchElementException)
	else p.success(x)
}

p.future

implement zip with async-await vs promise

def sequence(fts: List[Future[T]]) : Future[List[T]} = {
fts match {
	case Nil => Future(Nil)
	case (ft:: fts) => ft.flatMap (t => sequence (fts).flatMap (ts => Futuren(t::ts))

}


}


}


}


//race condition fill a promise
