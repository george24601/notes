val userData = ByteString("abc")
val authorization = headers.Authorization(BasicHttpCredentials("user", "pass"))
HttpRequest(
  PUT,
  uri = "/user",
  entity = HttpEntity(`text/plain` withCharset `UTF-8`, userData),
  headers = List(authorization),
  protocol = `HTTP/1.0`)

def credentialsOfRequest(req: HttpRequest): Option[User] =
  for {
    Authorization(BasicHttpCredentials(user, pass)) <- req.header[Authorization]
  } yield User(user, pass)


Get().withHeaders(ApiTokenHeader("TheKey")) ~> routes ~> check {
	status should ===(StatusCodes.OK)
		responseAs[String] should ===("extracted> apiKey: TheKey")
}

//checkout tostrict as well: force loading all datas into mem
response.entity.dataBytes
  .via(Framing.delimiter(ByteString("\n"), maximumFrameLength = 256))
    .map(transformEachLine)
      .runWith(FileIO.toPath(new File("/tmp/example.out").toPath))

//also, discard entity bytes


val entityFuture = Marshal(string).to[MessageEntity]
val entity = Await.result(entityFuture, 1.second)
entity.contentType shouldEqual ContentTypes.`text/plain(UTF-8)`

val errorMsg = "Easy, pal!"
val responseFuture = Marshal(420 -> errorMsg).to[HttpResponse]
val response = Await.result(responseFuture, 1.second)
response.status shouldEqual StatusCodes.EnhanceYourCalm
response.entity.contentType shouldEqual ContentTypes.`text/plain(UTF-8)`
val respFuture = Marshal(responseText).toResponseFor(request)

