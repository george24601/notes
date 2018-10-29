package eventSim

//how do we find out on whose behalf a signal expression is evaluated?
//this is global stack which handles cascading update

class StackableVariable[T](init: T) {
  private var values: List[T] = List(init)
  def value: T = values.head

  def withValue[R](newValue: T)(op: => R): R = {
    values = newValue :: values //add to stack
    try op finally values = values.tail //remove from the stack
  }
}

object NoSignal extends Signal[Nothing](???) {
  override def computeValue() = ()
}

class Signal[T](expr: => T) {
  import Signal._
  //current value

  private var value: T = _
  //current exp that defines the signal value
  private var myExpr: () => T = _
  //observing signals depending on its value
  private var observers: Set[Signal[_]] = Set()

  update(expr)

  protected def update(newEx: => T): Unit = {
    myExpr = () => newEx
    computeValue()
  }

  protected def computeValue(): Unit = {
    val newValue = caller.withValue(this)(myExpr()) //we may eval other signals, so we need to put ourselves on stack

    if (value != newValue) {
      value = newValue
      val obs = observers
      observers = Set() //empty the set, because the line below will repopulating observing signals, so we HAVE to clear it here
      obs.foreach(_.computeValue()) //broadcast value change, any still observer will call our apply() and in turn register themselves
    }
  }

  def apply(): T = {
    observers += caller.value //someone is calling us, how do we know who is calling us? need a data structure to know the current caller
    //it needs to be stack like, because our program is evaled in a stack way
    assert(!caller.value.observers.contains(this)) //cyclic dependency
    value
  }
}

object Signal {
  private val caller = new StackableVariable[Signal[_]](NoSignal) 
  //DynamicVariable for Thread-local storage, global hash table lookup in JVM could be a problem, if you multiplexed between several tasks
  //use implicit parameters => pure functional, more boiler plate
  def apply[T](expr: => T) = new Signal(expr) //so we can do Signal(expr) 
}

class Var[T](expr: => T) extends Signal[T](expr) {
  override def update(expr: => T): Unit = super.update(expr)
}

object Var {
  def apply[T](expr: => T) = new Var(expr)
}

object SignalVar extends App {
}