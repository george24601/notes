class_methods

let’s not access the instance variables directly, but let’s use the methods that the attr_reader created:. The error message is better this way


### Arel

When using Arel, you're mainly interacting with tables (Arel::Table) and nodes (Arel::Nodes::Node subclasses).

The query interface for ActiveRecord is built on top of Arel. Anytime you call things like Model.find_by, Model.where, Model.joins, ActiveRecord is using Arel to construct the SQL query string. Scope chains are basically chained Arel nodes. At any point in the scope chain, you can check the SQL query string that Arel will build by tossing a .to_sql at the end.




The & calls to_proc on the object, and passes it as a block to the method. In Ruby, to_proc is implemented on Symbol

In Active Record, objects carry both persistent data and behavior which operates on that data. Active Record takes the opinion that ensuring data access logic as part of the object will educate users of that object on how to write to and read from the database.

Model Class - Singular with the first letter of each word capitalized (e.g., BookClub).
Database Table - Plural with underscores separating words (e.g., book_clubs).

Foreign keys - These fields should be named following the pattern singularized_table_name_id (e.g., item_id, order_id). These are the fields that Active Record will look for when you create associations between your models.
Primary keys - By default, Active Record will use an integer column named id as the table's primary key 

created_at - Automatically gets set to the current date and time when the record is first created.
updated_at - Automatically gets set to the current date and time whenever the record is created or updated.
lock_version - Adds optimistic locking to a model.
type - Specifies that the model uses Single Table Inheritance.
`(association_name)_type` - Stores the type for polymorphic associations.
`(table_name)_count` - Used to cache the number of belonging objects on associations. For example, a comments_count column in an Article class that has many instances of Comment will cache the number of existent comments for each article.

The rule is that if you do not explicitly render something at the end of a controller action, Rails will automatically look for the action_name.html.erb template in the controller's view path and render it. So in this case, Rails will render the app/views/books/index.html.erb file.

If you want to render the view that corresponds to a different template within the same controller, you can use render with the name of the view

render tells Rails which view (or other asset) to use in constructing a response. The redirect_to method does something completely different: it tells the browser to send a new request for a different URL

Sometimes inexperienced developers think of redirect_to as a sort of goto command, moving execution from one place to another in your Rails code. This is not correct. Your code stops running and waits for a new request from the browser. It just happens that you've told the browser what request it should make next, by sending back an HTTP 302 status code.

The naming convention of controllers in Rails favors pluralization of the last word in the controller's name, although it is not strictly required (e.g. ApplicationController). For example, ClientsController is preferable to ClientController

the exact semantics of || are:

if first expression is not nil or false, return it
if first expression is nil or false, return the second expression

Any Ruby object can be frozen by using the freeze method. When an object is frozen, any attempt to change this object will result in a RuntimeError exception.

Foo.new create a new instance of Foo and before Foo.new returns, call the new
object's initialize method with all the arguments passed to Foo.new

class constant: starts with a capital letter instead of @@. Should not mutate
it. Publicly visible. To access, use :: ,e.g., Math::PI

conditials treats everything but false and nil as true

nil? method

Often convenicent for methods to return self so that subsequent method calls
can be put together


But blocks are not objects. can NOT pass them as arguments to a method.
Rather, any method can be passed either 0 or 1 blocks, sepearte from the other
arguments.

inject is like fold

map, select (filter in ML), any?, all?

Blocks are NOT closures because they are not objects => they are not
"first-class values", which is something that can be stored and passed like
anything else in the language

Suppose we want to create an array of blocks => cant because array holds
objects are blocks are not objects, but we can use lambda to create an array
of instances of Proc

```ruby
c = a.map {|x| lambda {|y| x >= y}}

c[2].call 17
j = c.count {|x| x.call(5)}

```


### Dynamic dispatch explained

support we have call e0.m(e1,....,en)

1.Evaluate e0,e1,...en to values obj0, obj1,...,objn
2.Get the calss of obj0 (think of the class as part of the state of obj0)
3.Suppose obj0 has class A, if m is defined in A, call that method. Otherwise, call the super classes recursivly
4.bind self to obj0 (different from FP), obj1...objn to x1....xn

Step 4 is what called "late-binding", "dynamic dispatch", "virtual method call"


### Dynamic dispatch vs Closures

Example: two ML functions
=> this creates two closures that both have the other closure in their environment => lexical scoping => subclass and dynamic dispatch would violate it

Overriding and dynamic dispatch is the biggest thing that distinguishes oop from functional programming
