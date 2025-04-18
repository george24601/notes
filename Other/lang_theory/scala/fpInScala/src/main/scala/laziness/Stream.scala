package laziness

//implement helper function for stream
sealed trait Stream[+A] {

  //!!! why the second param is lazily evaled?
  def foldRight[B](z: => B)(f: (A, => B) => B): B = this match {
    case Empty => z
    case Cons(h, t) => f(h(), t().foldRight(z)(f))
  }

  def toList: List[A] = {

    def toL(s: Stream[A]): List[A] = this match {
      case Empty => Nil

      case Cons(h, t) => h() :: toL(t())
    }

    toL(this)
  }

  //  (!!!)
  def take(n: Int): Stream[A] = if (n == 0) Empty
  else {
    this match {
      case Empty => Empty: Stream[A]
      case Cons(h, t) => Stream.cons(h(), this.take(n - 1))
    }
  }

  def drop(n: Int): Stream[A] = if (n == 0) this
  else {
    this match {
      case Empty => Empty
      case Cons(h, t) => t().drop(n - 1)
    }
  }

  def forAll(p: A => Boolean): Boolean = foldRight(false)((a, b) => p(a) && b)

  def takeWhile(p: A => Boolean): Stream[A] = foldRight(Empty: Stream[A])((aH, fromRight) => {
    if (p(aH))
      Stream.cons(aH, fromRight)
    else
      fromRight
  })

  //!!!
  def headOption: Option[A] = foldRight(None: Option[A])((aH, fromRight) => Some(aH))

  // Implement map, filter, append, and flatMap using foldRight. The append method should be non-strict in its argument.

  def map[B](f: A => B): Stream[B] = foldRight(Empty: Stream[B])((aH, fromRight) => Stream.cons(f(aH), fromRight))

  def filter(f: A => Boolean): Stream[A] = ???

  def append[B >: A](s: => Stream[B]): Stream[B] = foldRight(s)((aH, fromRight) => Stream.cons(aH, fromRight))

  def flatMap[B](f: A => Stream[B]): Stream[B] = foldRight(Empty: Stream[B])((aH, fromRight) => f(aH).append(fromRight))


  //Use unfold to implement map, take, takeWhile, zipWith (as in chapter 3), and zipAll
  //!!!
  def mapUF[B](f: A => B): Stream[B] = Stream.unfold(this)(

    s => s match {
      case Empty => None
      case Cons(h, t) => Some(f(h()), t())
    }
  )

  def zipWith[B, C](s2: Stream[B])(f: (A, B) => C): Stream[C] = ???

  //!!!!
  def zipAll[B](s2: Stream[B]): Stream[(Option[A], Option[B])] = Stream.unfold((this, s2)) {
      case (Cons(hA, tA), Empty) => Some((Some(hA()), None) , (tA(), Empty: Stream[B]))
      case (Empty, Cons(hB, tB)) => Some((None, Some(hB())) , (Empty: Stream[A], tB()))
      case (Cons(hA, tA), Cons(hB, tB)) => Some((Some(hA()), Some(hB())) , (tA(), tB()))
      case (Empty, Empty) => None
  }

  //!!!
  def startsWith[A](s: Stream[A]): Boolean= zipAll(s).takeWhile( _._2.isDefined).forAll{
    case (av, sv) => av == sv
  }

  //Implement tails using unfold.
  //For a given Stream, tails returns the Stream of suffixes of the input sequence, starting with the original Stream.
  def tails: Stream[Stream[A]] = Stream.unfold(this) {

    case Empty => None
    case Cons(h, t) => Some (this, t())
  }

  //Generalize tails to the function scanRight, which is like a foldRight that returns a stream of the intermediate results
  //!!!
  def scanRight[B](z: B)(f: (A, => B) => B): Stream[B] = foldRight((Empty:Stream[B], z)) (

    (aH, fromRight) => {
      lazy val cachedFR = fromRight
      val newBH = f(aH, cachedFR._2)

      (Stream.cons(newBH, cachedFR._1), newBH)
    }
  )._1


}

case object Empty extends Stream[Nothing]

//Note that this needs to be thunk instead of lazy evaled values
case class Cons[+A](h: () => A, t: () => Stream[A]) extends Stream[A]

object Stream {

  def cons[A](h: => A, t: => Stream[A]): Stream[A] = {
    lazy val hv = h;
    lazy val tv = t;

    Cons(() => hv, () => tv)
  }

  def empty[A]: Stream[A] = Empty

  ///!!! more efficient version
  def constant[A](a: A): Stream[A] = cons(a, constant(a))

  def from(n: Int): Stream[Int] = cons(n, from(n + 1))

  def fibs: Stream[Int] = {

    def genStream(prev2: Int, prev1: Int): Stream[Int] = cons(prev1 + prev2, genStream(prev1, prev1 + prev2))

    genStream(0, 1)
  }

  def unfold[A, S](z: S)(f: S => Option[(A, S)]): Stream[A] =
    f(z).map(as => cons(as._1, unfold(as._2)(f))).getOrElse(Empty: Stream[A])

  def fibsUF: Stream[Int] = unfold((0, 1))(as => Some(as._1 + as._2, (as._2, as._1 + as._2)))
}
