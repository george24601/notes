/* problems with function overload in scala: 
1. “Collisions” caused by type erasure, because JVM supports generic via type erasure (of types inside params)
2. No lifting into a function (of all overloads at the same time) (?!), espeically lifting a method into function
3. code dup in case of many similar overloads
4. Limitations with parameter defaults
5. Limitation with type inference on arguments

Create a method with only 1 parameter magnet of magnet type, with implicit conversions defined in the companion objects 

If an object has only one clearly defined behavior or if there is a central one, which clearly outrivals all others in terms of importance, modeling this behavior as an apply method is the natural choice. 

Problems:
1. no named params allowed any more
2. does not work well with call-by-name params
3. need a parameter list
4. applicable only when all potential types are known at the call site
*/


def complete(magnet: CompletionMagnet): magnet.Result = magnet()

private[module] sealed trait CompletionMagnet {
  type Result
  def apply(): Result
}

object CompletionMagnet {
  implicit def fromStatusObject[T :Marshaller](tuple: (StatusCode, T)) =
    new CompletionMagnet {
      type Result = Unit
      def apply(): Result 
    }
    implicit def fromHttpResponseFuture(future: Future[HttpResponse]) =
      new CompletionMagnet {
        type Result = Int
        def apply(): Result 
      }
      implicit def fromStatusCodeFuture(future: Future[StatusCode]) =
        new CompletionMagnet {
          type Result = Int
          def apply(): Result
        }
}


def host[T](obj: T)(implicit ev: T => String): Route => Route = ...

//will break in this context unless we wrap host around.but with magnet pattern we can push the implicits down one level
host("spray.io") {
  ... // some Route expression
}

def host(magnet: HostMagnet) = magnet()

sealed trait HostMagnet {
  def apply(): Route => Route
}

object HostMagnet {
  implicit def fromObj[T](obj: T)(implicit ev: T => String) =
    new HostMagnet {
      def apply() = ...
    }
}
