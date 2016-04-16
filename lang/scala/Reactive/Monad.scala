package testScala

object GeneratorTest extends App {
  println("hello!!!")

}

//monad has to satisfy 2 requirements
trait M[T]{
  self =>
  def flatMap[U](f: T => M[U]): M[U] //or bind
  def unit[T](x: T): M[T] //Generator's unit(x) = single(x)
  
  //implement other with these 2
  def map[U](f: T => U): M[U] = self flatMap (x => unit(f(x))) //equivalent to self flatMap (f andThen unit)
}


/* 
3 monad laws

associativity,i.e., you can inline nested for-expression
m flatMap f flatMap g == m flatMap (x => f(x) flatMap g)

left unit
unit(x) flatMap f == f(x)

right unit,i.e., for (x <- m) yield x
m flatMap unit == m

monads with zero: monad with withFilter defined
*/


/*
is Option type a monad?
left rule
Some(x) flatMap f = f(x)

right rule
None => None
Some(x) => unit(x) => Some(x)
 
associative law
opt match { case Some(x) => f(x) case None => None} 
    match {case Some(y) => g(y) case None => None} 

opt match { case Some(x) =>
 f(x)  match {case Some(y) => g(y) case None => None}
 case None => None}  //none is the trivial case


opt match { case Some(x) =>
 f(x) flatMap g
 case None => None} //i.e., opt flatMap (x => f(x) flatMap g) 
*/

abstract class Try[+T]{
   def flatMap[U](f: T => Try[U]): Try[U] = this match {
    case Success(x) => try f(x) catch { case scala.util.control.NonFatal(ex) => Failure(new Exception())  }
    case fail: Failure => fail
  }
  
  def map[U](f: T=> U): Try[U] = this match {
    case Success(x) => Try(f(x))
    case fail: Failure => fail
  }
}
case class Success[T](x: T) extends Try[T]
case class Failure(ex: Exception) extends Try[Nothing]

object Try{
  def apply[T](expr: => T): Try[T] =
    try Success(expr)
    catch{
      case scala.util.control.NonFatal(ex) => Failure(new Exception()) //should be ex, throwable vs exception?
    }
}


/*
so we can use Try as Some with for-expression

for {
 x<- computeX //so x, y is the content of monad
 y<- computeY

} yield f (x, y) //yield gives the content of the new monad, notice the new monad will have same type, as per definition of monads

this expands to 

computeX flatMap (x => for ( y <- computeY } yield f (x, y))

if computeX and computeY both Success(x), return Success(f(x, y)),  otherwise, Failure(ex)
*/

/*
Is Try a monad? with unit = Try?

right rule: Try(x) flatMap unit should be Try (x)

left rule: Try(x) flatMap f should be f(x)
success: try f(x) catch {Failure(ex)} this is not equivalent to f(x)


Example use of try monad:

val adventure = new Adventure()
val t1: Try[Int] = adventure.collect().flatMap(coins => { adventure.buy(coins) })

  //this is equvalent to
 val t2: Try[Int] = for {
    coins <- adventure.collect()
    treasure <- adventure.buy(coins)
  } yield treasure

*/


