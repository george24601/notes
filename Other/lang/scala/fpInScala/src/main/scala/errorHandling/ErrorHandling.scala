package errorHandling

/**
 * Created by georgeli on 16-09-10.
 */
object ErrorHandling {

  //implement all the functions besides map and getOrElse without resorting to pattern matching.
  trait MyOp[+A] {
    def map[B] (f: A => B): Option[B] = ???
    def getOrElse[B >: A] (default: => B): B = ???

    def flatMap[B] (f: A=> Option[B]): Option[B] = map(f).getOrElse(None)

    //!!!
    def orElse [B >: A] (default : => Option[B]): Option[B] = map(a => Option(a)).getOrElse(default)

    //(!!!)
    def filter(f : A => Boolean) : Option [A] = flatMap(a => if(f(a)) Some(a) else None)
  }

  //Implement the variance function in terms of flatMap
  def variance(xs: Seq[Double]): Option[Double] = {

    def mean(xs: Seq[Double]) = if (xs.length== 0) None else Some(xs.foldLeft(0.0) (_ + _)  /xs.length)

    mean(xs).flatMap( m => mean(xs.map(x => math.pow(x - m, 2))))
  }

  //If either Option value is None, then the return value is too
  def map2[A,B,C](a: Option[A], b: Option[B])(f: (A, B) => C): Option[C] = a.flatMap(va => b.map(vb=> f(va, vb)))

  //combines a list of Options into one Option containing a list of all the Some values in the original list.
  //If the original list contains None even once, the result of the function should be None;
  def sequence[A](a: List[Option[A]]): Option[List[A]] =
    a.foldRight(Some(Nil): Option[List[A]])((ah, fromRight) => map2(ah, fromRight) ((av, lv) => av::lv) )

  //implment WITHOUT sequence and map
  def traverse[A, B](a: List[A])(f: A => Option[B]): Option[List[B]] =
    a.foldRight(Some(Nil): Option[List[B]])((ah, fromRight) => map2(f(ah), fromRight) ((av, lv) => av::lv))

  trait MyEither[+E, +A]{
    //Note the first 3 uses PM directly
    def map[B] (f: A=> B): Either [E, B] = ???
    def flatMap[EE >: E, B] (f : A => Either[EE, B]) : Either [EE, B] = ???
    def orElse[EE >: E, B >: A] (b : A => Either[EE, B]) : Either [EE, B] = ???
  }

  //def map2[E, A,B,C](a: Either[E, A], b: Either[E, B])(f: (A, B) => C): Either[E, C] = a.flatMap(va => b.map(vb=> f(va, vb)))

  def sequence[E, A](es: List[Either[E, A]]): Either[E, List[A]] = ???

  def traverse[E, A, B](as: List[A])(f: A => Either[E, B]): Either[E, List[B]] = ???
}

