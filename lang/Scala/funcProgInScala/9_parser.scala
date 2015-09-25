import scala.util.matching.Regex

trait Parsers[Parser[+_]] { self =>
  def char(c: Char): Parser[Char] //just invent a combinator for char
  def run[A](p: Parser[A])(input: String): Either[ParseError,A]
  implicit def string(s: String): Parser[String]

  //since or is left-biased, we will make s2 call by name
  def or[A](s1: Parser[A], s2: =>Parser[A]): Parser[A]

  implicit def operators[A](p: Parser[A]) = ParserOps[A](p)
  implicit def asStringParser[A](B : A)(implicit  f: A => Parser[String]) : ParserOps[String] =
    ParserOps(f(B))

  case class ParserOps[A](p: Parser[A]){

    def | [A](s2: Parser[A]) = self.or(p, s2)
    def or[A](s2: => Parser[A]) = self.or(p, s2)
  }

  def listOfN[A](n: Int, p: Parser[A]): Parser[List[A]] =
    if (n == 0)
      succeed(List())
    else
      map2(p, listOfN(n-1, p)) (_ :: _)


  def many[A](p: Parser[A]): Parser[List[A]] = or(succeed(List()), map2(p, many(p))(_ :: _))

  def map[A,B](a: Parser[A])(f: A => B): Parser[B] = flatMap(a)(aL => succeed(f(aL)))

  def succeed[A](a: A): Parser[A]

  def slice[A](p: Parser[A]): Parser[String]

  def flatMap[A,B](p: Parser[A])(f: A => Parser[B]): Parser[B]

  //similar to the reasoning of map2, p2 has to be lazy evaled to avoid infinite recursion
  def product[A,B](p: Parser[A], p2: => Parser[B]): Parser[(A,B)] = flatMap(p)(a => flatMap(p2)(b => succeed(a,b)))

  def many1[A](p: Parser[A]): Parser[List[A]] = map2(p, many(p))(_ :: _)

  //notice how often we use p2 recursively, this means p2 has to be call by name, otherwise infinite recursion
  def map2[A,B,C](p: Parser[A], p2: => Parser[B])(f: (A,B) => C): Parser[C] = flatMap(p) (a => flatMap(p2)
    (b => succeed(f(a,b))) )

  implicit def regex(r: Regex): Parser[String]

  def label[A](msg: String)(p: Parser[A]): Parser[A]

  case class Location(input: String, offset: Int = 0) {
    lazy val line = input.slice(0,offset+1).count(_ == '\n') + 1
    lazy val col = input.slice(0,offset+1).lastIndexOf('\n') match {
      case -1 => offset + 1
      case lineStart => offset - lineStart
    }
  }

  def errorLocation(e: ParseError): Location
  def errorMessage(e: ParseError): String

  def scope[A](msg: String)(p: Parser[A]): Parser[A]

  case class ParseError(stack: List[(Location,String)])

  def attempt[A](p: Parser[A]): Parser[A]
}
