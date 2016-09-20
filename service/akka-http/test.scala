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

//Sync testing for atomic works
val actorRef = TestActorRef[MyActor]
val actor = actorRef.underlyingActor

val future = actorRef ? Say42
val Success(result: Int) = future.value.get
result should be(42)

//we expect this actorRef to throw exception anyway
intercept[IllegalArgumentException] { actorRef.receive("hello") }

//async testing for sequence of incoming events
//

//implict sender means testActor will be the sender reference
class MySpec() extends TestKit(ActorSystem("MySpec")) with ImplicitSender
with WordSpecLike with Matchers with BeforeAndAfterAll {

  override def afterAll {
    TestKit.shutdownActorSystem(system)
  }

  "An Echo actor" must {

    "send back messages unchanged" in {
      val echo = system.actorOf(TestActors.echoActorProps)
      echo ! "hello world"
      expectMsg("hello world")
    }

  }
}

//Expecting Log Messages to handle exception
