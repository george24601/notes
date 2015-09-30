package ParserCombinator

/*
In FP, it’s common to define an algebra and explore its expressiveness without having a concrete implementation
 */

trait JSON
object JSON {
  case object JNull extends JSON
  case class JNumber(get: Double) extends JSON
  case class JString(get: String) extends JSON
  case class JBool(get: Boolean) extends JSON
  case class JArray(get: IndexedSeq[JSON]) extends JSON
  case class JObject(get: Map[String, JSON]) extends JSON

  def jsonParser[Parser[+_]](P: Parsers[Parser]):Unit = {

    def nullP:Parser[JSON] = P.map(P.string("null"))(s => JNull)
    def bool = P.map(
      P.or(P.string("true"), P.string("false"))
    )(s => JBool(s == "true"))

    def DQ = P.char('"')
    def LB = P.char('[')
    def RB = P.char(']')

    //TODO: get the parsing string literal part
    def noQStringP = P.string("\"") //should be a regex

    def QStringP = P.product(DQ, P.product(noQStringP, DQ))
  }
}