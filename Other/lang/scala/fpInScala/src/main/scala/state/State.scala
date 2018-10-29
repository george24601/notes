package state

/**
 * Created by georgeli on 16-09-11.
 */
trait RNG {
  def nextInt: (Int, RNG)
}


object StateAns {
  type Rand[+A] = RNG => (A, RNG)

  ///!!!
  def nonNegativeInt(rng: RNG): (Int, RNG) = {
    val (v1, nextRNG) = rng.nextInt

    if (v1 >= 0)
      (v1, nextRNG)
    else
      (-(v1 + 1), nextRNG)
  }

  //generate a Double between 0 and 1, not including 1
  def double: Rand[Double] = map(nonNegativeInt)(v1 => v1 / (Int.MaxValue.toDouble + 1))

  def map[A, B](s: Rand[A])(f: A => B): Rand[B] =
    rng => {
      val (a, rng2) = s(rng)
      (f(a), rng2)
    }

  def map2[A, B, C](ra: Rand[A], rb: Rand[B])(f: (A, B) => C): Rand[C] = rng => {
    val (a, rng1) = ra(rng)
    val (b, rng2) = rb(rng1)

    (f(a, b), rng2)
  }


  def intDouble(rng: RNG): ((Int, Double), RNG) = {

    val (i, rng1) = rng.nextInt
    val (d, rng2) = double(rng1)
    ((i, d), rng2)
  }

  def sequence[A](fs: List[Rand[A]]): Rand[List[A]] = rng => fs match {
    case Nil => (Nil, rng)
    case h :: t => {
      val (hv, hrng) = h(rng)
      val (tv, trng) = sequence(t)(hrng)

      (hv :: tv, trng)
    }
  }

  def ints(count: Int)(rng: RNG): (List[Int], RNG) = {
    val lr = List.fill(count)( (ra : RNG) => ra.nextInt)

    sequence(lr)(rng)
  }

  def flatMap[A,B](f: Rand[A])(g: A => Rand[B]): Rand[B] = rng => {

    val (av, arng) = f(rng)
    g(av) (arng)
  }

  def mapFM[A, B](s: Rand[A])(f: A => B): Rand[B] = flatMap(s)(a => rng2 => (f(a), rng2))

  def map2FM[A, B, C](ra: Rand[A], rb: Rand[B])(f: (A, B) => C): Rand[C] = flatMap(ra) (
  a => rngB => {
    val (vB, rngB2) = rb(rngB)

    (f(a, vB), rngB2)
  }
  )


}

sealed trait Input
case object Coin extends Input
case object Turn extends Input

case class Machine(locked: Boolean, candies: Int, coins: Int)

case class State[S,+A](run: S => (A,S)){

  def map[B](f: A => B): State[S, B] = ???

  def map2[B, C](b: State[S, B])(f: (A, B) => C): State[S, C] = ???

  def get[S]: State[S, S] = State(s => (s, s))
  def set[S](s: S): State[S, Unit] = State(_ => ((), s))

  def flatMap[B](f: A => State[S,B]): State[S, B] = ???
}

object Ans611{
  def simulateMachine(inputs: List[Input]): State[Machine, (Int, Int)] = ???

}
