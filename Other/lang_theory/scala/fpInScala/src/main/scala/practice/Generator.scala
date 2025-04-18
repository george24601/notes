package practice

//1. create a Generator[T] monad with map
trait Generator[T] {

  self =>

  def generate(): T

  def unit(v: T) = new Generator[T] {
    def generate() = v
  }

  def flatMap[S](f: T => Generator[S]) = new Generator[S] {
    def generate() = f(self.generate()).generate()
  }

  def map[S](f: T => S) = new Generator[S] {
    def generate() = f(self.generate())
  }
}

trait GeneratorMonad extends Practice {

  //2. create a Generator[Int] with random int generation. This will be our base Generator
  val intGen = new Generator[Int] {
    val rand = new java.util.Random

    def generate() = rand.nextInt(3)
  }

  //3. create a Generator[Bool] with 2)
  val boolGen = for (i <- intGen) yield i % 2 == 0

  //4. create a Generator[(Int, Int)] with 2)
  val pairIntGen = for {
    first <- intGen
    second <- intGen
  } yield (first, second)

  //5. generate (T, U) pair with a Generator[T], and Generator[U]
  def createGen[T, U](genT: Generator[T], genU: Generator[U]) = for {
    t <- genT
    u <- genU
  } yield (t, u)

  //6. create a Generator[List[Int]], use Generator[Bool] to decide if use empty list or not

  val emptyListGen = new Generator[List[Int]] {
    def generate() = Nil
  }

  val nonEmptyListGen: Generator[List[Int]] = for {
    head <- intGen
    tail <- listGen
  } yield  head :: tail

  val listGen: Generator[List[Int]] = for {
    empty <- boolGen
    list <- if(empty) emptyListGen else nonEmptyListGen
  } yield list

  def run() = {
    println(pairIntGen.generate())
    println(listGen.generate())
  }
}
