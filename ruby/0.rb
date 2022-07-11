#You are not limited to querying fields from a single table, you can query multiple tables as well.
Order.joins(:customer, :books).pluck("orders.created_at, customers.email, books.title")

#This command will return a set of values as a hash and put them into the results variable
results = ActiveRecord::Base.connection.execute(sql)

#.exec_query returns an ActiveRecord::Result object which is very handy with easily accessible .columns and .rows attributes
#you'd typically want to use .entries when using .exec_query to get the results as an array of hashes
ActiveRecord::Base.connection.exec_query(sql)

if results.present?

# Your database might start throwing "Too many connections" errors if you have code that uses ActiveRecord::Base.connection without calling ActiveRecord::Base.clear_active_connections!
@connection = ActiveRecord::Base.connection
result = @connection.exec_query('select tablename from system.tables')
result.each do |row|
puts row
end

#Once you get the MySql::Result object
results = ActiveRecord::Base.connection.execute(query)
#will make array of this format [[row1][row2]...]
results.to_a

Client.find_by_sql("
  SELECT * FROM clients
  INNER JOIN orders ON clients.id = orders.client_id
  ORDER BY clients.created_at desc
")
# => [<Client id: 1, first_name: "Lucas" >, <Client id: 2, first_name: "Jan">...]

Model.connection.select_all('sql').to_hash

Client.connection.select_all("SELECT first_name, created_at FROM clients
   WHERE id = '1'").to_hash
# => [
  {"first_name"=>"Rafael", "created_at"=>"2012-11-10 23:23:45.281189"},
  {"first_name"=>"Eileen", "created_at"=>"2013-12-09 11:22:35.221282"}
]

result = Post.connection.select_all('SELECT id, title, body FROM posts')
# Get the column names of the result:
result.columns
# => ["id", "title", "body"]

# Get the record values of the result:
result.rows
# => [[1, "title_1", "body_1"],
      [2, "title_2", "body_2"],
      ...
     ]

# Get an array of hashes representing the result (column => value):
result.to_hash
# => [{"id" => 1, "title" => "title_1", "body" => "body_1"},
      {"id" => 2, "title" => "title_2", "body" => "body_2"},
      ...
     ]

# ActiveRecord::Result also includes Enumerable.
result.each do |row|
  puts row['title'] + " " + row['body']
end



sql = "Select * from ... your sql query here"
# records_array will be of different types for different database adapters. If you're using PG, it will be an instance of PG::Result, not Array.
# you'd need to call values on this PG::Result object to get the results array
records_array = ActiveRecord::Base.connection.execute(sql)







#returning the connection back to the connection pool afterwards
res = ActiveRecord::Base.connection_pool.with_connection { |con| con.exec_query( "SELECT 1;" ) }


class Person
  
  def initialize
    @name = "Gabriella" #a class initialized with an instance variable @name
  end
end

new_person = Person.new
new_person.name # NoMethodError: undefined method `name’ 

# The two are similar
attr_reader :engine

def engine
  @engine
end

# refactoring is easier. From
attr_reader :engine

# To 
def engine
  @engine ||= EngineFactory.create
end


class TicTacToe

attr_accessor :grid
def reset_game
    self.grid = game.create_grid(players) #self is required
  end
end


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

