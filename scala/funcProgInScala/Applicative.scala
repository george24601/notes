/**
 * Created by georgeli on 15-09-27.
 */
trait Applicative[F[_]] {

  def map2[A, B, C](fa: F[A], fb: F[B]) (f :(A,B) => C): F[C]
  def unit[A] (a : => A): F[A]

  //apply is alternative primitive to map2
  def apply[A,B](fab: F[A =>B]) (fa: F[A]): F[B] = map2(fab, fa) ((f,a) => f(a))

  def map[A, B](fa : F[A])(f: A => B): F[B] = map2(fa, unit())( (a, _) => f(a))

  def traverse[A, B](as : List[A]) (f: A => F[B]): F[List[B]]

  def sequence[A](fas: List[F[A]]): F[List[A]] = fas match {
    case Nil => unit(Nil)
    case head :: tail => {
      val tailSeq = sequence(tail)
      map2(head, tailSeq) ((ele, list) => ele:: list )
    }
  }
  def replicateM[A](n: Int, fa: F[A]): F[List[A]] =
    if (n == 0)
      sequence(List(fa))
    else {
      val tailF = replicateM(n - 1, fa)
      map2(fa, tailF) ((a, list) => a::list)
    }

  def product[A,B](fa: F[A], fb: F[B]): F[(A,B)] = map2(fa, fb) ((a,b) => (a,b))

}
