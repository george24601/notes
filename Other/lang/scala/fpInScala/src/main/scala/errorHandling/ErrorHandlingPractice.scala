package errorHandling

/**
 * Created by georgeli on 16-09-10.
 */
object ErrorHandlingPractice {

  //implement all the functions besides map and getOrElse without resorting to pattern matching.
  trait MyOp[+A] {
    def map[B] (f: A => B): Option[B] = ???
    def getOrElse[B >: A] (default: => B): B = ???

    def flatMap[B] (f: A=> Option[B]): Option[B] = ???

    //!!!
    def orElse [B >: A] (default : => Option[B]): Option[B] = ???

    //(!!!)
    def filter(f : A => Boolean) : Option [A] =  ???
  }

  def map2[A,B,C](a: Option[A], b: Option[B])(f: (A, B) => C): Option[C] = a.flatMap(va => b.map(vb=> f(va, vb)))

  //combines a list of Options into one Option containing a list of all the Some values in the original list.
  //If the original list contains None even once, the result of the function should be None;
  def sequence[A](a: List[Option[A]]): Option[List[A]] = ???

  //implment WITHOUT sequence and map
  def traverse[A, B](a: List[A])(f: A => Option[B]): Option[List[B]] = ???
}

