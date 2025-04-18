package gettingStarted

object GettingStarted{
  //Note that we define a function inside to use the scope!
  def isSorted[A](as: Array[A], ordered: (A,A) => Boolean): Boolean ={

    def sorted_r(i : Int) : Boolean = i == as.length - 1 || (ordered(as(i), as(i+1)) &&  sorted_r(i+1))

    sorted_r(0)
  }

  //another example def partial1[A,B,C](a: A, f: (A,B) => C): B => C

  def curry[A,B,C](f: (A, B) => C): A => (B => C) = (a : A) =>( (b: B) => f(a,b))

  //Notice that (a,b): (A, B) does not work!
  def uncurry[A,B,C](f: A => B => C): (A, B) => C = (a,b) => f(a)(b)

  def compose[A,B,C](f: B => C, g: A => B): A => C = a => f(g(a))

}

object FDS{

  ///For data types, it’s a common idiom to have a variadic apply method in the companion object to conveniently construct instances of the data type.
  // By calling this function apply and placing it in the companion object,

  //The main reason for grouping the arguments this way is to assist with type inference.

  //!!!
  def length[A](as: List[A]): Int = as.foldRight(0) ((_,acc) => acc + 1)

  ///how is foldleft, foldright implemented?

  //(!!!!)stack safe fold left
  def foldLeft[A,B](as: List[A], z: B)(f: (B, A) => B): B = as match  {
    case Nil => z
    case h::t => foldLeft(t, f(z, h))(f)
  }

  //note that this also means we can reverse and then implement foldRight to avoid SO!

   //Write sum, product, and a function to compute the length of a list using foldLeft.

  def sum(as: List[Int]) = foldLeft(as, 0) (_ + _)

  //(!!!!)Write a function that returns the reverse of a list (given List(1,2,3) it returns List(3,2,1)).
  //See if you can write it using a fold.
  def rev[A](as: List[A]) = as.foldLeft(Nil: List[A]) ( (reved, h) => h :: reved)

  //(!!!)implement foldLeft in terms of foldRight
  def fl[A,B](as: List[A], z: B)(f: (B, A) => B): B = {
    type EvalTail = B => B

    //def calcRes(aH: A, curB: B, fromRight: EvalTail) : B =  fromRight(f(curB, aH))

    def ff : (A, EvalTail) => EvalTail =  (aH: A, fromRight: EvalTail) => (curB:B)=> fromRight(f(curB, aH))

    def fz : B => B = (b:B) => b //Do nothing to preserve the accumed value

    val res = as.foldRight(fz) (ff)

    res(z)
  }

  //implement foldRight in terms of foldLeft
  //TODO: check this answer
  def fr[A,B](as: List[A], z: B)(f: (B, A) => B): B = {

    type DelayedCalc = B => B

    def unitDelayed : DelayedCalc  = (b : B) => b

    def foldDelay : (DelayedCalc, A) => DelayedCalc =
      (delayLeft : DelayedCalc, aH : A) => (BfromRight: B) => delayLeft(f(BfromRight, aH))

    val res = as.foldLeft(unitDelayed) (foldDelay)

    res(z)
  }

  //(!!!)Implement append in terms of either foldLeft or foldRight.
  def appendFR[A](a1: List[A], a2: List[A]): List[A] = a1.foldRight(a2) ((aH, merged) => aH :: merged)
  //foldLeft just need to reverse a1 first

  //(!!!)Hard: Write a function that concatenates a list of lists into a single list.
  //Its runtime should be linear in the total length of all lists. Try to use functions we have already defined.
  def conc[A](ll: List[List[A]]) : List[A] = ll.foldRight(Nil : List[A]) ( (fromll, merged) => appendFR(fromll, merged))

  //question: why this version does not run linear time?
  def conc2[A](ll: List[List[A]]) : List[A] = ll.foldLeft(Nil : List[A]) ( (fromll, leftMerged) => appendFR(leftMerged, fromll))

  //Write a function that transforms a list of integers by adding 1 to each element,
  //try using fold instead of explicit recursive function
  def fAdd1(ns : List[Int]): List[Int]= ns.foldRight(Nil: List[Int]) ( (curN, fromRight) => (curN + 1) :: fromRight)

  //Write a function that turns each value in a List[Double] into a String
  //try using fold instead of explicit recursive function
  def fDToS (ds: List[Double]): List[String] = ds.foldRight(Nil: List[String]) ( (curN, fromRight) => curN.toString :: fromRight)

  //use fold to do implement
  def map[A,B](as: List[A])(f: A => B): List[B] = as.foldRight(Nil: List[B]) ( (curN, fromRight) => f(curN) :: fromRight)

  //use fold to implement this
  def filter[A](as: List[A])(f: A => Boolean): List[A] = as.foldRight(Nil: List[A]) ((curN : A, fromRight) => if (f(curN)) curN :: fromRight else fromRight)

  def flatMap[A,B](as: List[A])(f: A => List[B]): List[B] = conc(map(as)(f))

  //(!!!)Use flatMap to implement filter.
  def filterFM[A](as: List[A])(f: A => Boolean): List[A] = flatMap(as) (a => if(f(a)) List(a) else Nil)

  ///Implement the function however comes most naturally
  def hasSubsequence[A](sup: List[A], sub: List[A]): Boolean = ???
}
