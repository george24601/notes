%i[ ] # Non-interpolated Array of symbols, separated by whitespace
%i[ test ]
# => [:test]

blog = { id: 1, name: 'Ruby 2.5', description: 'BigBinary Blog' }
# => {:id=>1, :name=>"Ruby 2.5", :description=>"BigBinary Blog"}

blog.slice(:name, :description)
# => {:name=>"Ruby 2.5", :description=>"BigBinary Blog"}

"
There isn't a &: operator in Ruby. What you are seeing is the & operator applied to a :symbol.

In a method argument list, the & operator takes its operand, converts it to a Proc object if it isn't already (by calling to_proc on it) and passes it to the method as if a block had been used.
"

a.each_slice(2).map(&:reverse)

my_proc = Proc.new { puts "foo" }

my_method_call(&my_proc) # is identical to:
my_method_call { puts "foo" }
