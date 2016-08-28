import scala.util.Random

/**
 * Created by georgeli on 15-09-24.
 *
 * Notice in this example we use 2 monads, one for generation, one for testing
 */
trait Gens {
  //trait Gen[A] //Simple monad type, representing the generation

  case class State[S, A] (run : S => (S, A))

  type RNG = Random
  type Gen[A] = State[RNG, A]

  type SuccessCount = Int
  type FailureInfo = String

  trait Prop //common pattern with monad is the separation of definition and execution. In this case, Prop holds the definition, and you have to explicitly call check to execute it
  {
    def check: Either[SuccessCount, FailureInfo] //check has to return something so we can compose it
    def && (p : Prop) : Prop //ANOTHER combinator function
  }

  def listOf[A] (gen: Gen[A]) : Gen[List[A]] //The power of monad lies in the chain reaction, i.e., unlike monoid, the behavior of the second moand is affected by the first one

  def forAll[A] (l: Gen[List[A]]) (f : A => Boolean) : Prop

  def choose(start: Int, stopExclusive: Int): Gen[Int] = State(rng=> (rng, rng.nextInt()))

  def unit[A](a:A): Gen[A] = State(rng => (rng, a))

  def uniform: Gen[Double]= State(rng => (rng, rng.nextDouble))

  def listOfN[A] (n : Int, g: Gen[A]): Gen[List[A]] = if (n == 0) unit(Nil) else
      State(rng => {
        val headGen= g.run(rng)

        val tailGen = listOfN(n-1, g).run(headGen._1)

        (tailGen._1, headGen._2 :: tailGen._2)
      })

  def map[A, B](g: Gen[A]) (f : A => B): Gen[B] = State(
  rng => {
    val curSA = g.run(rng)
   (curSA._1, f(curSA._2))
  }
  )

  def flatMap[A, B](g: Gen[A])(f: A => Gen[B]): Gen[B] = State(rng => {
    val aSA = g.run(rng)
    f(aSA._2).run(aSA._1)
  })

}
