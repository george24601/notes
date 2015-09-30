package ParserCombinator
import scala.util.matching.Regex

trait Parsers[Parser[+_]] {

  def char(s :Char) : Parser[Char] //constant value parser
  def string(s :String) : Parser[String] //constant value parser
  def succeed[A](a: A): Parser[A] //unit for monad

  def run[A](p: Parser[A])(input: String): Either[ParseError, A] //separate description and execution

  def or[A](s1: Parser[A], s2: =>Parser[A]): Parser[A] //since OR is left-biased, we will make s2 call by name

  def flatMap[A,B](p: Parser[A])(f: A => Parser[B]): Parser[B] //context-sensitive parsing

  def map[A,B](a: Parser[A])(f: A => B): Parser[B] = flatMap(a)(aL => succeed(f(aL)))

  //notice how often we use p2 recursively, this means p2 has to be call by name, otherwise infinite recursion
  def map2[A,B,C](p: Parser[A], p2: => Parser[B])(f: (A,B) => C): Parser[C] =
   flatMap(p) (a => flatMap(p2) (b => succeed(f(a,b))) )

  //we can do many(p) because p2 is call by name
  def many[A](p: Parser[A]): Parser[List[A]] = or(succeed(List()), map2(p, many(p))(_ :: _))

  def listOfN[A](n: Int, p: Parser[A]): Parser[List[A]] = if (n == 0) succeed(List()) else
    map2(p, listOfN(n-1, p)) (_ :: _)

  //checks which part of string is consumed, slice is very likely to be primitive, because we require it will not create an internal list when run
  def slice[A](p: Parser[A]): Parser[String]

  //p2 is lazy evaled, because we should not consider second one if first one failed
  def product[A,B](p: Parser[A], p2: => Parser[B]): Parser[(A,B)] = flatMap(p) (a => flatMap(p2)(b => succeed(a,b)))

  def regex(r: Regex): Parser[String]

  ///ERROR REPORT PART STARTS HERE
  //if p fails, its ParseError will somehow incorporate msg.
  def label[A](msg: String)(p: Parser[A]): Parser[A]

  //adds additional information in the event that p fails.
  def scope[A](msg: String)(p: Parser[A]): Parser[A]

}