  /*
  first iteration

  we introduce prop as properties, we will do combinations on that!
  trait Prop { self =>
    //def run: Unit //side effect function!

    def check : Boolean
    def &&(p: Prop): Prop = new Prop {
      override def check: Boolean = self.check && p.check
    }
  }

  */
 trait Prop {
  import Prop._
    def check: Either[(FailedCase, SuccessCount), SuccessCount]
  }

  object Prop {
    type FailedCase = String
    type SuccessCount = Int
  }

  class State[S,A](run: S => (A,S))

  case class Gen[A](sample: State[RNG,A]) {
    def choose(start: Int, stopExclusive: Int): Gen[Int] = {

      def newRun(rng :RNG) : (Int, RNG) = {
        val (newInt, newRng) = rng.nextInt

        if (newInt >= start && newInt <= stopExclusive)
          (newInt, newRng)
        else
          newRun(newRng)
      }

      new Gen[Int](
        new State[RNG, Int](newRun)
      )
    }
  }

  /*
  def listOf[A](a: Gen[A]): Gen[List[A]]

  def listOfN[A](n: Int, a: Gen[A]): Gen[List[A]]

  def forAll[A](a: Gen[A])(f: A => Boolean): Prop
  */

