object GeneratorTest extends App {
  println("hello!!!")


//insight: map, flatMap, and with Filter is all you need to use for-expression

//trait to generate random values
trait Generator [+T]{
    self => //alias for "this"
 def generate: T 
 
 def map[S](f: T => S): Generator[S] = new Generator[S] {
   def generate = f(self.generate)
 }
 
 def flatMap[S] (f: T => Generator[S]): Generator[S] = new Generator[S] {
   def generate = f(self.generate).generate
 }
}

val integers = new Generator[Int] {
  val rand = new java.util.Random
  def generate = rand.nextInt()
}

val pairsGen = new Generator[(Int, Int)]{
  def generate = (integers.generate, integers.generate) //how to get rid of Generator boilerplate?
}

val booleans = for (x <- integers) yield x > 0

val bool1 = integers map (x => x > 0)

val bool2 = new Generator[Boolean] {
  def generate = integers.generate > 0 //skipped one step of expanding: (x: Int => x > 0) (integers.generate)
} 

//expand the for form
def pairs[T, U](t: Generator[T], u:Generator[U]) = t flatMap {
    x => u map { y => (x, y)}
}

//expand again
def pairs2[T, U](t: Generator[T], u:Generator[U]) = t flatMap {
    x => new Generator [(T, U)] {
      def generate= (x,  u.generate)
    }
}

//expand yet again 
def pairs3[T, U](t: Generator[T], u:Generator[U]) = new Generator [(T, U)]{
  def generate = (new Generator [(T, U)] {
      def generate= (t.generate,  u.generate)
    }).generate
}

//simplify: generate
def pairs4[T, U](t: Generator[T], u:Generator[U]) = new Generator [(T, U)] {
      def generate= (t.generate,  u.generate) //back to our simple form!
    }

///list generator
def single[T](x: T): Generator[T] = new Generator[T] {
  def generate = x
}

def emptyLists = single(Nil)

//recursive definition
def nonEmptyLists = for {
  head <- integers
  tail <- lists
  
} yield head :: tail

def lists: Generator[List[Int]] = for {
  isEmpty <- booleans
  list <- if (isEmpty) emptyLists else nonEmptyLists
} yield list



trait Tree
case class Inner(left:Tree, right: Tree) extends Tree
case class Leaf(x: Int) extends Tree

//generator that creates random Tree objects

//ScalaCheck: use generator to write test case, write properties that should hold instead of explicit test

}
