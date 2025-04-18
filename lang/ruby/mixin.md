Various patterns such as Plugin, Service Locator, or Dependency injection are employed to facilitate the run-time provisioning of the chosen low-level component implementation to the high-level component

The direct effect is that the UI doesn't need to reference the ApplicationLayer or any concrete package that implements the ICustomerHandler. The concrete class will be loaded using reflection. At any moment the concrete implementation could be replaced by another concrete implementation without changing the UI class. Another interesting possibility is that the Page class implements an interface IPageViewer that could be passed as an argument to ICustomerHandler methods. Then the concrete implementation could communicate with UI without a concrete dependency. Again, both are linked by interfaces.

The principle states:[1]

High-level modules should not import anything from low-level modules. Both should depend on abstractions (e.g., interfaces).
Abstractions should not depend on details. Details (concrete implementations) should depend on abstractions.

By dictating that both high-level and low-level objects must depend on the same abstraction, this design principle inverts the way some people may think about object-oriented programming

ian interface has been used to invert the dependency. The direction of dependency can be chosen to maximize policy code reuse, and eliminate cyclic dependencies.

Instead of PA::OA calls PB::OB directly. Note PB is considered lower layer of abstraction compared to PA
PA::OA needs PA::IA
PA::IA implemented by PB::OB
However, this ameks PB hard to reuse, thus, we can put all abstraction part into a separate component

It is called inverted because the lower level, instead of being refed by lower level, now has the knowledge of what the caller expects

TemplateResponseMixin has to be applied to classes that contain self.request (CODE), and while this doesn't mean exclusively classes derived from View, it is clear that it has been designed to augment that specific type.

a mixin is not intended to be used by itself.
an exception would be raised and the code wouldn’t be running. We expect some other code to define this method somewhere. We expect our Mixin to be “mixed in” with other classes and other code.

Unfortunately, the use of inheritance over composition often leads to systems that, paradoxically, increase code duplication. The main problem lies in the fact that inheritance can directly delegate to only one other class (the parent class), as opposed to composition, where the object can delegate to any number of other ones. This limitation of inheritance means that we might have a class that inherits from another one because it needs some of its features, but doing this receives features it doesn't want, or shouldn't have.

Every object in Ruby also has a singleton class. Methods added to this singleton class can be directly called on the object and so they act as "class" methods. When we use "extend" on an object and pass the object a module, we are adding the methods of the module to the singleton class of the object:

```ruby

module M
  def m
    puts 'm'
  end
end

class Test
end

Test.extend M
Test.m

Test.singleton_class.ancestors
 => [#<Class:Test>, M, #<Class:Object>, ...

```

When we use "include" and pass it a module, it adds the module to the ancestor chain right before the class that we are inheriting from

```ruby
class Parent
end 

module M
end

class Child < Parent
  include M
end

Child.ancestors
 => [Child, M, Parent, Object ...
```

ActiveRecord should not use inheritance, but rather include a module to add the behavior (mostly persistence) to a model/class. ActiveRecord is simply using the wrong paradigm.

Modules don’t have instances. It follows that entities or things are generally best modeled in classes, and characteristics or properties of entities or things are best encapsulated in modules. Correspondingly, as noted in section 4.1.1, class names tend to be nouns, whereas module names are often adjectives (Stack versus Stacklike)

This flexibility should be not that surprising since mixins/traits contribute to composition just the behavior point of view (an object has a behavior) whereas real inheritance, also in JS, is responsible for the is a thing relationship.

A mixin is typically used with multiple inheritance. So, in that sense, there's "no difference".

The detail is that a mixin is rarely useful as a standalone object. an Interface with an associated Implementation

The name "mix-in" indicates it is intended to be mixed in with other code. As such, the inference is that you would not instantiate the mix-in class on its own.

i.e., mixin: implementation complete, interface not so, AC interface is complete, implementation not so

Mixins are sometimes described as being "included" rather than "inherited". So don't view them as inheritance

Similar to multiple inheritance, it can result in a "diamond inheritance problem", where two super classes can inherit from the same class

A mixin class acts as the parent class, containing the desired functionality. A subclass can then inherit or simply reuse this functionality, but not as a means of specialization. Typically, the mixin will export the desired functionality to a child class, without creating a rigid, single "is a" relationship. Here lies the important difference between the concepts of mixins and inheritance, in that the child class can still inherit all the features of the parent class, but, the semantics about the child "being a kind of" the parent need not be necessarily applied.

 In this case, while Scala keeps track of "mixed in types" for the type checker, method definitions themselves are flattened into the actual types so there is no parent-child established within the JVM classes. Inheritance is generally associated with a runtime polymorphic method resolution - but mixins are (largely) orthogonal concepts. Java 8 interface Default Methods are mixins as well.

however, aren't inheritance – it's actually more similar to dynamically adding a set of methods into an object. Whereas inheritance says "This thing is a kind of another thing", mixins say, "This object has some traits of this other thing." You can see this in the keyword used to declare mixins: trait.

t is "Is the subclass of the trait truly a kind of the trait or are the behaviors in the trait behaviors that reduce boilerplate". Typically it is best implemented by mixing in traits to objects rather than extending the trait to create new classes.

 The withObjectBasedListLastBehavior mixin provides a generically implemented last method for list like structures. This structure by itself does not effect anything. Via Object.assign the last list-behavior can be assigned to any list-like structure. - similar to ordered trait in scala


