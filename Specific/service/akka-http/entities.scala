//Consuming or discarding of entity is mandatory. Otherwise, it assumes the data should be backpressured, and use tcp's backpressure mechanism to stall incoming data!
//Use strict entity to force loading into memeory 

val strictEntity: Future[HttpEntity.Strict] = response.entity.toStrict(3.seconds)

val transformedData: Future[ExamplePerson] =
  strictEntity flatMap { e =>
    e.dataBytes
      .runFold(ByteString.empty) { case (acc, b) => acc ++ b }
      .map(parse)
  }

//we care only the response code, but not the payload
val discarded: DiscardedEntity = response1.discardEntityBytes()
discarded.future.onComplete { case done => println("Entity discarded completely!") }


val route =
  path("bid") {
    put {
      entity(as[Bid]) { bid =>
        incoming entity is fully consumed and converted into a Bid
        complete("The bid was: " + bid)
      }
    }
  }

val route =
  (put & path("lines")) {
    withoutSizeLimit {
      extractRequest { r: HttpRequest =>
        val finishedWriting = r.discardEntityBytes().future

        // we only want to respond once the incoming data has been handled:
        onComplete(finishedWriting) { done =>
          complete("Drained all data from connection... (" + done + ")")
        }
      }
    }
  }

val route =
  (put & path("lines")) {
    withoutSizeLimit {
      extractDataBytes { data => 
        //hard abort
        data.runWith(Sink.cancelled) // "brutally" closes the connection

        //wait until full upload is done and then close the con
        respondWithHeader(Connection("close"))
        complete(StatusCodes.Forbidden -> "Not
          allowed!")
      }
    }
  }
