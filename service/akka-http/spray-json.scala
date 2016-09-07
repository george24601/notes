final case class Item(name: String, id: Long)
final case class Order(items: List[Item])

trait JsonSupport extends SprayJsonSupport with DefaultJsonProtocol {
  implicit val itemFormat = jsonFormat2(Item)
  implicit val orderFormat = jsonFormat1(Order) // contains List[Item]
}

val route =
  get {
    pathSingleSlash {
      complete(Item("thing", 42)) // will render as JSON
    }
} ~  post {
  entity(as[Order]) { order => // will unmarshal JSON to Order
    val itemsCount = order.items.size
    val itemNames = order.items.map(_.name).mkString(", ")
    complete(s"Ordered $itemsCount items: $itemNames")
  }
}

val transformedData: Future[ExamplePerson] =
  strictEntity flatMap { e =>
    e.dataBytes
      .runFold(ByteString.empty) { case (acc, b) => acc ++ b }
      .map(parse)
  }


