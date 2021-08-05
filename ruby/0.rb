table = Employee.arel_table
table
  .project(table[Arel.star])
  .where(table[:first_name].eq('Ryan').and(table[:last_name].eq('Stenberg')))
  .to_sql

class EmployeeFullNameSearch < Struct.new(:first, :last)
  def sql
    arel_table
      .project(arel_table[Arel.star])
      .where(where_clause(first, last))
      .to_sql
  end
  private
  def arel_table
    @arel_table ||= Employee.arel_table
  end
  def where_clause
    arel_table[:first_name].eq(first).and arel_table[:last_name].eq(last)
  end

  def results
    Employee.where(full_name_matches('Ryan', 'Stenberg'))
  end
end

EmployeeFullNameSearch.new('Ryan', 'Stenberg').results

class Conference < ActiveRecord::Base
  DEADLINES = %i(
    speaker_submission_deadline
    early_bird_registration_deadline
    standard_registration_deadline
  )
  scope :with_deadlines_on, -> (date, deadlines = DEADLINES) { where(deadlines_on(date, deadlines)) }
  def self.deadlines_on(date, deadlines = DEADLINES)
    Array(deadlines).reduce(nil) do |query, deadline|
      deadline_check = arel_table[deadline].eq(date)
      if query.nil?
        deadline_check
      else
        query.or(deadline_check)
      end
    end.to_sql
  end
  # Given the default deadlines, we're basically doing this:
  # arel_table[:speaker_submission_deadline].eq(date)
  #   .or(arel_table[:early_bird_registration_deadline].eq(date))
  #   .or(arel_table[:standard_registration_deadline].eq(date))
  #   .to_sql
end

# With given deadlines:
Conference.with_deadlines_on(
  1.month.from_now,
  %i(early_bird_registration_deadline standard_registration_deadline)
)
# Without (matching any deadline):
Conference.with_deadlines_on(1.month.from_now)



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

