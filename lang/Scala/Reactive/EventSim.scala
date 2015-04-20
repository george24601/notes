package eventSim

trait Simulation {
  type Action = () => Unit
  case class Event(time: Int, action: Action)

  private var currentTime = 0;
  private var agenda: List[Event] = List()
  def delayAction(delay: Int)(block: => Unit): Unit = { //notice it passes a block
    val item = Event(currentTime + delay, () => block)
    updateAgenda(agenda, item)
  }

  def updateAgenda(agenda: List[Event], item: Event): Unit = {

  }

  def loop(): Unit = agenda match {
    case first :: tail =>
      agenda = tail
      currentTime = first.time
      first.action()
      loop()
    case Nil =>
  }
}

trait Parameters {
  def AndDelay = 7
}

abstract class Gate extends Simulation {

  def AndDelay: Int //notice def here

  class Wire {
    private var signal = false
    private var actions: List[Action] = Nil //notice how privates are inited here

    def getSig: Boolean = signal

    def setSig(newSig: Boolean) = {
      if (newSig != signal) {
        signal = newSig

        actions.foreach(_()) //anoymous fuction here , need to broadcast sig chances
      }
    }

    def addAction(newAction: Action) = {
      actions = newAction :: actions
      newAction() //first action
    }
  }

  def andGate(first: Wire, second: Wire, out: Wire) = {
    def delayed(): Unit = {
      val firstVal = first.getSig
      val secondVal = second.getSig

      //delayed action here
      delayAction(AndDelay) {
        out.setSig(firstVal && secondVal)
      }
    }

    first.addAction(delayed) //register here 
    second.addAction(delayed)
  }

  //can add a probe action to wire to print inner state
}

object EventSim extends App {
  println("hello!")

  object sim extends Gate with Parameters //mixin with Parameters

  import sim._ //need to import concrete here!
  val first, second, out = new Wire //notice the init pattern

  andGate(first, second, out)

  first setSig true
  loop()
  second setSig true
  loop()
}