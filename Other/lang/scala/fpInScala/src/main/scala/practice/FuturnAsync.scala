package practice

import scala.concurrent.Future

/**
 * Created by georgeli on 16-06-26.
 */
trait FuturnAsync {
  //implement retry with Future and fallbackTo
  def retry (noTimes: Int) (block: => Future[T]): Future[T] = {
    if(noTimes == 0)
      Future.failed(new Exception("can no longer retry"))
    else
      block.fallbackTo(
      retry(noTimes - 1) ( block)
      )
  }

  //3. async/await is implicit future, implement retry with async/await
  //4. implment Future.filter with async/await


//5. implment Future.flatmap with async/await
  */
  //6. implment sequence. convert a List[Future[T]] to Future[List[T]]
  def sequence(fts: List[Future[T]]) : Future[List[T]] = fts match {
    case Nil => Future(Nil)
    case head:: tail => for {
     futureTail <- sequence(tail)
    } yield head :: futureTail


  }
}
