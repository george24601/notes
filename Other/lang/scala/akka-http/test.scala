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
//
//

val probe1 = TestProbe()
val probe2 = TestProbe()
val actor = system.actorOf(Props[MyDoubleEcho])
actor ! ((probe1.ref, probe2.ref))
actor ! "hello"
probe1.expectMsg(500 millis, "hello")
probe2.expectMsg(500 millis, "hello")

val probe = new TestProbe(system) {
  def expectUpdate(x: Int) = {
    expectMsgPF() {
      case Update(id, _) if id == x => true
    }
    sender() ! "ACK"
  }
}

//TestProbe can register itself for DeathWatch of any other actor


val probe = TestProbe()
val future = probe.ref ? "hello"
probe.expectMsg(0 millis, "hello") // TestActor runs on CallingThreadDispatcher
probe.reply("world")
assert(future.isCompleted && future.value == Some(Success("world")))


val probe = TestProbe()
val source = system.actorOf(Props(classOf[Source], probe.ref))
val dest = system.actorOf(Props[Destination])
source ! "start"
probe.expectMsg("work")
probe.forward(dest)

/*
To test parent-child relationship

when creating a child, pass an explicit reference to its parent
create the child with a TestProbe as parent
create a fabricated parent when testing
when creating a parent, tell the parent how to create its child
(more details to come!)
*/

//Tracing actor invocation!
