Get() ~> smallRoute ~> check {
  responseAs[String] shouldEqual "Captain on the bridge!"
}

Get("/ping") ~> smallRoute ~> check {
  responseAs[String] shouldEqual "PONG!"
}

//seal is there to capture rejection
Put() ~> Route.seal(smallRoute) ~> check {
  status === StatusCodes.MethodNotAllowed
  responseAs[String] shouldEqual "HTTP method not allowed, supported methods: GET"
}
