In FP, we break programs down into functions that perform some ops
In OOP, we break programs down into classes that give behavior to some kind of data => need double dispatch to deal with ops with multiple arguments

Example:
Expression for language such as for arithmetic
variatns of expressions: int, neg, add
operations over expressions: eval them, convert to strings, hasZero

FP approach
datatype for expressions, with one ctor for each variant
define function for each operation
in each function, have a branch for each variant of data => may use wildcard pattern to avoid enumberation all the branches

i.e., procedural decomposition => each procedure corresponds to each operation

OOP
define a class for expressions
subclass for each variant of data
in each subclass, have a mehtod def for each ops => use super class to implement default behaviour

If we add a new op
FP approach: 
add a new function
add a new data type
all functions with a new case

Exactly opposite with FP approach

-------
visitor pattern in OOP to support new operations (often with double dispatch)
IN FP, can find datatypes to have an "other" posibility and opertions to take in a function that can process the "other data"

Note you can not wrap the original datatype in a newdatatype to support new data type => so your ADD can not have Mult

In fact, languages often provide contructs exactly to prevent extensibility: ML moduels can hide datatpes, Java's final prevents subclasses

----

interface:
An interface is a type, can solve some problems with multiple inheritance
fundamental to type checking, which is why they dont exist in ruby

```ruby
module Color
	attr_acceotr:color
	def darken
		self.color = "dart" + self.color
	end
end

class ColorPt < Pt
	include Color
end
```

often, mixins call other methods on self that are not defined by the mixin. Instead, the mixin assumes that all clases that include the mixin define this method

interface: purely for type checking purposes. Therefore, no need for dynamically-typed languages to have interface. Similarly there is no need to have abstract method 

---
Type system flexibility
ML: parametric polymorphism/generics
C#: subtype polymorphism/subtyping

---
Simple type system rules

1. if e1 has type t1, e2 has t2, then {f1 = e1, f2 = e2} has type {f1:t1, f2:t2}
2. If e has a record type containing f: t, then e.f has type t
3. if e1 has a record  f: t and e2 has type t, then e1.f = e2 has type t

=> relax type rule a bit

if some exp has a record type, then let the expression also have a type where some of the fields are removed => letting an expression that has one type also hae another type that has less information is the idea of subtyping

=> 4. If e has type t1 and t1 <: t2 then e has type t2

if our goal is to prevent field-missing erors, then we cannot add any subtyping rules that would cause us to stop meeting our goal 
=> "subtyping is not a matter of opinion"
=> width subtyping: A subtype can have a subset of fields with the same type,i.e., a subtype can have "extra" fileds
=> permutation subtyping: A supertype can have the same set of fields with the same types in a different order
=> if t1 <: t2, and t2 <: t3, then t1 <: t3
=> Every type is a subtype of itself

--------
so "depth checking"

e.g. passing a sphere into a circle function => will not type check, because the type is {{x, y, z}, r} instead of {{x, y}, r}

if ta <: tb then {f1:t1,....,f:ta,...fn:tn} <: {f1:t1,....,f:tb,...,fn:tn}

problem: the member will be mutated into a supertype!!=> so if the field is not settable (immutable) depth subtyping rule is sound

------

Java's array allows depth subcheckng, and will raise runtime excpetion if the subtype array is assigned a supertype

Java and c# allow null to have any object type, so every field access and method call includes a run-time check for null => NullPonterException => proposals to never hold null support, e.g., Option types in ML

---
function subtyping
if ta <: tb then t->ta <: t-> tb => return tyeps are covariants for function subtyping meaning the subtyping for the return types works "the same way" as for types overall

but argument types are NOT covariant for function subtyping => but contravariance, i.e. => f accepting super type

If tb <: ta, then ta -> t <: tb -> t

function subtyping is needed for higher-order functions or for stoirng functions themselves in records

---
a subtype can have extra fields
because fields are mutable, a subtype cannot have a different type for a field
a subytpe can have extra methods
because methods are immutable, a subtype can have a subtype for a method, which means the method in the subtype can have contravariant argument types and a covaraint result type
=> a subclass can override a method a with a covaraint return type

class and types are different! => class defines an object's behavior, a type describes what fields an object has and what messages it can respond to. Subtyping is a question of substitutability and what we want to flag as a type error

-----------

Subtyping is a bad substitute for Generics
in general, when you use Object and downcasts, you are essentially taking a dynamic typing approach

key of generic => mark mutliple uses of that is of same type

Generics are a bad substitute for subtyping
---
bounded generic types:
instead of just saying "a subtype of T" or "for all types 'a" => for all types 'a that are a subtype of T =>

static <T extends Pt> List<T> inCircle(List<T> pts, Pt center, double radius)
{
}
