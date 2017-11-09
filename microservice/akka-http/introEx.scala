def main1(){
  implicit val system = ActorSystem("my-system")
  implicit val materializer = ActorMaterializer()
  // needed for the future flatMap/onComplete in the end
  implicit val executionContext = system.dispatcher

  val route =
    path("hello") {
      get {
        complete(HttpEntity(ContentTypes.`text/html(UTF-8)`, "<h1>Say hello to akka-http</h1>"))
      }
    }

  val bindingFuture = Http().bindAndHandle(route, "localhost", 8080)

  bindingFuture
    .flatMap(_.unbind()) // trigger unbinding from the port
    .onComplete(_ => system.terminate()) // and shutdown when done
}

def main2(){
  get{
    pathPrefix("item" / LongNumber) { id =>
      val maybeItem: Future[Option[Item]] = fetchItem(id)

      onSuccess(maybeItem) {
        case Some(item) => complete(item)
        case None       => complete(StatusCodes.NotFound)
      }
    }
  }~
post {
  path("create-order") {
    entity(as[Order]) { order =>
      val saved: Future[Done] = saveOrder(order)
      onComplete(saved) { done =>
        complete("order created")
      }
    }
  }
}
}

def main3(){
  val numbers = Source.fromIterator(() =>
      Iterator.continually(Random.nextInt()))

  val route =
    path("random") {
      get {
        complete(
          HttpEntity(
            ContentTypes.`text/plain(UTF-8)`,

            numbers.map(n => ByteString(s"$n\n"))
          )
        )
      }
    }
}

def main4(){
  val route =
    path("auction") {
      put {
        parameter("bid".as[Int], "user") { (bid, user) =>
          auction ! Bid(user, bid)
          complete((StatusCodes.Accepted, "bid placed"))
        }
      }
      get {
        implicit val timeout: Timeout = 5.seconds
        val bids: Future[Bids] = (auction ? GetBids).mapTo[Bids]
        complete(bids)
      }
    }

  val responseFuture: Future[HttpResponse] =
      Http().singleRequest(HttpRequest(uri = "http://akka.io"))
}


