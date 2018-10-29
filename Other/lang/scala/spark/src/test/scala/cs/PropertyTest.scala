package cs

import org.scalatest.{Matchers, FunSuite}
import org.scalatest.prop.{Checkers, PropertyChecks}
import org.scalacheck.Gen

class PropertyTest extends FunSuite with PropertyChecks with Matchers{

  case class Fraction(n: Int, d: Int) {

    require(d != 0)
    require(d != Integer.MIN_VALUE)
    require(n != Integer.MIN_VALUE)

    val numer = if (d < 0) -1 * n else n
    val denom = d.abs

    override def toString = numer + " / " + denom
  }

  val fracGen = for {
    top <- Gen.choose(-1000, 1000)
    bottom <- Gen.choose(-1000, 1000) if bottom != 0 //filter on the Gen
  } yield Fraction(top, bottom)

 test("with provided generatoer") {
    forAll ((fracGen, "Fraction")) { (f: Fraction) => //first part gives parameter names to help debugging and logging
         f.denom should be > 0
        //f.denom should be <= 0 //. Choose reversed to see the error boundary
      }
  }
  /*
  test("simple example from scalatest online") {
    forAll ("num", "denom") { (n: Int, d: Int) => //first part gives parameter names to help debugging and logging

      whenever(d != 0 && d != Integer.MIN_VALUE
        && n != Integer.MIN_VALUE) {

        val f = new Fraction(n, d)

        if (n < 0 && d < 0 || n > 0 && d > 0)
          assert(f.numer > 0)
        else if (n != 0)
          assert(f.numer < 0)
        else
          assert(f.numer == 0)

         f.denom should be > 0
        //f.denom should be <= 0 //. Choose reversed to see the error boundary
      }
    }
  }
  */
}
