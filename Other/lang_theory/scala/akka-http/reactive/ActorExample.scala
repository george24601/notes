import akka.actor.Actor
import akka.actor.Props
import akka.event.LoggingReceive
/*
 Scenario: support wire transfer between bank accounts
 
 */
//model activites as actors
//need functionality to keep track of account balance, from/to

//need functionality to do actual transfer
//good practice to define messages in companion objec
object WireTransfer {
  case class Transfer(from: ActorRef, to: ActorRef, amount: BigInt)
  case object Done
  case object Failed
}

object BankAccont {
  case class Deposit(amount: BigInt) {
    require(amount > 0) //notice the use of require here
  }
  case class Withdraw(amount: BigInt) {
    require(amount > 0)
  }
  case object Done
  case object Failed

}

class BankAccont extends Actor {
  import BankAccount._

  var balance = BigInt(0)

  def receive = {
    case Depsoite(amount) =>
      balance += amount
      sender ! Done //sender is implicit value inside Actor
    case withdraw(amount) if amount <= balance => //notice the if here
      balance -= amount
      sender ! Done

    case _ => sender ! Failed
  }
}

class WireTransfer extends Actor {
  import WireTransfer._
  def receiver = { //reciever defines available messages
    case Transfer(from, to, amount) =>
      from ! BankAccount.Withdraw(amount) //sends message

      /*
      we can not proceed until withdraw is good, i.e., we need to wait for withdraw's ACK
      so we need to update the message we are listening to
      update local actor state via context, suspend its execution
      */
      context.become(awaitWithdraw(to, amount, sender))  
  }

  def awaitWithdraw (to: ActorRef, amount: BigInt, client: ActorRef): Receive = {
    case BankAccount.Done => //withdraw is good
      to ! BankAccount.Deposit(amount)  //deposite
      context.become(awaitDeposit(client)) //wait for ack
  case BankAccount.Failed ->
      client ! Failed 
      context.stop(self) //this transfer is invalid, shut it down
  }

  def awaitDeposit(client: ActorRef) : Receive = {
    case BankAccount.Done =>
      client ! Done
      context.stop(self) //transaction good, conclude it
}

class TransferMain extends Actor {
  val accountA = context.actorOf(Props[BankAccount], "accountA")
  val accountB = context.actorOf(Props[BankAccount], "accountA")
  
  accountA ! BankAcount.Deposit(100)
  
  def receive = LoggingReceive {
    case BankAccount.Done => transfer(50) //deposite is done, start tranferring
  }
  
  def transfer(amount: BigInt): Unit = {
      val transcation = context.actorOf(Props[WireTransfer], "transfer")
      transaction ! WireTransfer.Transfer(accountA, accountB, amount)
      context.become(LogggingReceive {
        case WireTransfer.Done =>
          println("success")
          context.stop(self)
        case WireTransfer.Failed =>
          context.stop(self)
        })
      }
  }
  

}