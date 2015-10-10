package Categories

trait Monoid[A] {
  def op(a1: A, a2: A): A
  def zero: A
}

object Examples {
  def optionMonoid[A] : Monoid[Option[A]] = new Monoid[Option[A]] {
    def op(a1: Option[A], a2: Option[A]): Option[A] = (a1, a2) match {
      case (_, None) => a1
      case (None, _) => a2
      case  _ => a1
    }

    def zero: Option[A] = None
  }

  def endoMonoid[A]: Monoid[A => A] = new Monoid[A => A] {

    def op(a1: A => A, a2: A => A): A => A = a => a2(a1(a))
    def zero: A => A = a => a
  }

  def concatenate[A] (as: List[A], m: Monoid[A]): A = as match {
    case Nil => m.zero
    case head:: tail => m.op(head, concatenate(tail, m))
  }

  def foldMap[A,B](as: List[A], m: Monoid[B]) (f : A=> B): B = concatenate(as.map(f), m)
}

