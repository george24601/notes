package testScala

object GeneratorTest extends App {
  println("hello!!!")

}

/*
 
 digital circuit simulation
 
 The components have a reaction time,i.e., their outputs dont change immediately after a change to their inputs
 */
trait Parameters {
  def InverterDelay = 2
  def AndGateDelay = 3
  def OrGateDelay = 5
}

trait Simulation {
  type Action = () => Unit
  case class Event(time: Int, action: Action)
  private type Agenda = List[Event]
  private var agenda: Agenda = List()
  private var currentTime = 0
  
  def InverterDelay = 2
  def AndGateDelay = 3
  def OrGateDelay = 5
  
  def afterDelay (delay: Int) (block: => Unit): Unit = {
    val item = Event (currentTime + delay, () => block) //why wrap it again?
    agenda = insert (agenda, item)
  }

  //insert events, sorted by time
  private def insert (ag: List[Event], item:Event):List[Event]= ag match {
    case first :: rest if first.time <= item.time =>
      first :: insert(rest, item)
    case _ =>
      item :: ag
  }
  
  private def loop(): Unit = agenda match {
    case first :: rest =>
      agenda = rest
      currentTime = first.time
      first.action()
      loop()
    case Nil => //no agenda
  }
  
  def run(): Unit = {
    afterDelay(0) {
      println("test")      
    }
    
    loop()
  }
  
  class Wire {
    var sigVal = false
    var actions: List[Action] = Nil //actions attached to the wirte

    def getSignal: Boolean = sigVal
    def setSignal(s: Boolean): Unit =
      if (s != sigVal) {
        sigVal = s
        actions foreach (_()) //all attached actions are executed at each change of the transported signal, i.e. broadcast to all gates this wire goes to
      }

    def addAction(a: Action): Unit = {
      actions = a :: actions
      a() //activate the action now, the real effect kicks in after delay
    }
  }
  
  def probe (name: String, wire: Wire): Unit = {
    def probeAction(): Unit = {
      //can print here
    }
    
    wire addAction probeAction
  }

  def inverter(input: Wire, output: Wire): Unit = {
    def invertAction(): Unit = {
      val inputSig = input.getSignal
      afterDelay(InverterDelay) { output setSignal !inputSig } //output is closured
    }

    input addAction invertAction
  }

  def andGate(in1: Wire, in2: Wire, output: Wire): Unit = {
    def andAction(): Unit = {
      val in1Sig = in1.getSignal
      val in2Sig = in2.getSignal
      afterDelay(AndGateDelay) { output setSignal (in1Sig & in2Sig) }
    }

    in1 addAction andAction //in1 and in2 both need to know of this event, but this also mean andAction will be run once by each in wire
    in2 addAction andAction
  }

}


