package gettingStarted

object Practice{

  //another example def partial1[A,B,C](a: A, f: (A,B) => C): B => C
  def curry[A,B,C](f: (A, B) => C): A => (B => C) =  ???

  //Notice that (a,b): (A, B) does not work!
  def uncurry[A,B,C](f: A => B => C): (A, B) => C = ???

  def compose[A,B,C](f: B => C, g: A => B): A => C =  ???

  ///For data types, it’s a common idiom to have a variadic apply method in the companion object to conveniently construct instances of the data type.
  // By calling this function apply and placing it in the companion object,

  //The main reason for grouping the arguments this way is to assist with type inference.

  //!!!
  def length[A](as: List[A]): Int = ???

  ///how is foldleft, foldright implemented?

  //(!!!!)stack safe fold left
  def foldLeft[A,B](as: List[A], z: B)(f: (B, A) => B): B = ???

  //(!!!!)Write a function that returns the reverse of a list (given List(1,2,3) it returns List(3,2,1)).
  //See if you can write it using a fold.
  def rev[A](as: List[A]) = ???

  //(!!!)implement foldLeft in terms of foldRight
  def fl[A,B](as: List[A], z: B)(f: (B, A) => B): B = ???

  //(!!!)Implement append in terms of either foldLeft or foldRight.
  def appendFR[A](a1: List[A], a2: List[A]): List[A] = ???
  //foldLeft just need to reverse a1 first

  //(!!!)Hard: Write a function that concatenates a list of lists into a single list.
  //Its runtime should be linear in the total length of all lists. Try to use functions we have already defined.
  def conc[A](ll: List[List[A]]) : List[A] = ???

  //use fold to do implement
  def map[A,B](as: List[A])(f: A => B): List[B] = ???

  //(!!!)Use flatMap to implement filter.
  def filterFM[A](as: List[A])(f: A => Boolean): List[A] = ???

  ///Implement the function however comes most naturally
  def hasSubsequence[A](sup: List[A], sub: List[A]): Boolean = ???
}
