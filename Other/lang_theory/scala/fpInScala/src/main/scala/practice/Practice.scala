package practice

/**
 * Created by georgeli on 16-06-26.
 */
trait Practice {
  def run()
}

trait MainProg {
  this : Practice =>

  def main(args: Array[String]): Unit = {
    run()
  }
}
