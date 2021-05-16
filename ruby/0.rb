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

int.times {puts "hi"}

y = 7 
[4,6,8].each {y += 1}

sum = 0
[4,6,8].each {|x| 
sum += x
puts sum
}

sum = [4,6,8].inject(0) {|acc, elt| acc + elt}

class Point
attr_accessor :x, :y

def initialize(x,y)
	@x = x
	@y = y
end

def distFromOrigin
	Math.sqrt(@x * @x + @y * @y)
end

def distFromOrigin2
	Math.sqrt(x * x + y * y)//uses getter method
end

end

class ColorPoint < Point
attr_accessor :color

def initialize(x,y,c="clear")
	super(x,y) //not required but often desired
	@color = c
end

end

