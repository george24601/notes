package ParserCombinator

class ParserImpl[+A]


object ParserImpl //extends Parsers[ParserImpl]
{
  type Parser[+A] = String => Either[ParseError, A]

  def run[A](p: Parser[A])(input: String): Either[ParseError, A] = Left(ParseError(Nil))


  def string(s: String): Parser[String] = (input: String) =>
    if (input.startsWith(s)) Right(s) else Left(Location(input).toError(s))
}

