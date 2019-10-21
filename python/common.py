list = ['larry', 'curly', 'moe']
  list.append('shemp')         ## append elem at end
  list.insert(0, 'xxx')        ## insert elem at index 0
  list.extend(['yyy', 'zzz'])  ## add list of elems at end
  print list  ## ['xxx', 'larry', 'curly', 'moe', 'shemp', 'yyy', 'zzz']
  print list.index('curly')    ## 2

  list.remove('curly')         ## search and remove that element
  list.pop(1)                  ## removes and returns 'larry'
  print list  ## ['xxx', 'moe', 'shemp', 'yyy', 'zzz']

list = [1, 2, 3]
  print list.append(4)   ## NO, does not work, append() returns None
  ## Correct pattern:
  list.append(4)
  print list  ## [1, 2, 3, 4]

list = ['larry', 'curly', 'moe']
if 'curly' in list: #in addition to the for-loop usage
  print 'yay'

  # Split the line into chunks, which are concatenated automatically by Python
  text = (
    "%d little pigs come out, "
    "or I'll %s, and I'll %s, "
    "and I'll blow your %s down."
    % (3, 'huff', 'puff', 'house'))


a, b, c = 1, 2L, "john"
#casting
int(value)
str(value)
float(value)
bool(value) # Will only return false for an empty string or an int=0
list_of_ints = [int(i) for i in list_of_strings]

# With newline
print("Hello World");
# Without newline
print("Hello World", end='')

for n in range(10, 0, -2) :
    print(n)

for c in "string" :
  print(c)

#scala style yield is possible, called generator here

name = input("Enter name\n")
age = int(input("Enter age\n"))
print("Name is ", name ," and age is ", age)

# replace some values
# However, out of range slice indexes are handled gracefully when used for slicing
letters[2:5] = ['C', 'D', 'E']

letters[2:5] = []

a, b = 0, 1
while b < 10:
    print(b)
    #print(b, end=',') The keyword argument end can be used to avoid the newline after the output, or end the output with a different string
    a, b = b, a+b

if x < 0:
    x = 0
    print('Negative changed to zero')
elif x == 0:
    print('Zero')
elif x == 1:
    print('Single')
else:
    print('More')    


words = ['cat', 'window', 'defenestrate']
for w in words:
    print(w, len(w))

#A tuple consists of a number of values separated by commas
t = 12345, 54321, 'hello!'
u = t, (1, 2, 3, 4, 5) #((12345, 54321, 'hello!'), (1, 2, 3, 4, 5))
#Note that tuple uses (, list [ in py, and { in cpp 

tel = {'jack': 4098, 'sape': 4139}

#The comparison operators in and not in check whether a value occurs (does not occur) in a sequence. The operators is and is not compare whether two objects are really the same object; this only matters for mutable objects like lists. All comparison operators have the same priority, which is lower than that of all numerical operators.
'guido' in tel

'jack' not in tel

del tel['sape']

#swap values
x, y = 1, 2
x, y = y, x

#Combining a list of strings into a single one
sentence_list = ["my", "name", "is", "George"]
sentence_string = " ".join(sentence_list)

#Merging dictionaries
x = {'a': 1, 'b': 2}
y = {'b': 3, 'c': 4}
z = {**x, **y}

for key in x:
    print(x[key])

#Returning multiple values from a function
def get_a_string():
    a = "George"
    b = "is"
    c = "cool"
    return a, b, b
sentence = get_a_string()
(a, b, c) = sentence

#Iterating over a dictionary
m = {'a': 1, 'b': 2, 'c': 3, 'd': 4}
for key, value in m.items():
    print('{0}: {1}'.format(key, value))

#Iterating over list values while getting the index too
m = ['a', 'b', 'c', 'd']
for index, value in enumerate(m):
    print('{0}: {1}'.format(index, value))


#Initialising empty containers
a_list = list()
a_dict = dict()
a_map = map()
#Curly braces or the set() function can be used to create sets. Note: to create an empty set you have to use set(), not {}; the latter creates an empty dictionary, a data structure that we discuss in the next section.
a_set = set()

#multiple assignment & with tuple
a,b,c=3,4,5
my_tuple=3,4,5
x,y,z=my_tuple


"""
The *args and **kwargs is a common idiom to allow arbitrary number of arguments to functions as described in the section more on defining functions in the Python documentation.

The *args will give you all function parameters as a tuple:

The **kwargs will give you all keyword arguments except for those corresponding to a formal parameter as a dictionary.

Another usage of the *l idiom is to unpack argument lists when calling a function.
"""

mylist = [1,2,3]
foo(*mylist)

mydict = {'x':1,'y':2,'z':3}
foo(**mydict)


###Working with lists
list = [] # create a new list
list.append("A") # add to the end
list.insert(3,"D") # insert at an index
sorted_list = sorted(list) # returns a new, sorted list
list.sort() # in place sort
list.remove("C") # remove first occurrence of "C"
popped = list.pop(2) # return and remove the item at index 2
list.reverse() # reverse the list
a = list.index("A") # return index of "A"
list += ["E","F"] # add a list with E and F to the end of this list
size = len(list) # size of the list

###working with sets
set_of_words1 = set() # create a new set. Note that we do not use {}, as that is for the dict
set_of_words1.add("The") # add values
set_of_words1.add("A")
set_of_words1.add("Boat")
print("Boat" in set_of_words1) # True
set_of_words2 = {"Anchor","A","Coast"} # create another set and populate it
print(set_of_words1.intersection(set_of_words2)) # intersection
print(set_of_words1.union(set_of_words2)) # union
for value in set_of_words2 : # all values
    print(value)

###tuple, note it is immutable
words =  ("Good", "Morning") # or words = "Good", "Morning"
print("Good" in words) # True
print(hash(words)) # This is what makes the tuples so special - they are hashable
a,b = words # or a,b = "Good", "Morning"
print(a) # Good
print(b) # Morning
print(len(words)) # 2

###Map
wordcount_map = {} # create a new, empty dict
wordcount_map = {"anchor":2, "dock":3} # create a new dict and add key-values
wordcount_map["the"] = 10 # add keys and values
wordcount_map["a"] = 8
wordcount_map["boat"] = 1
print(wordcount_map["the"]) # value of a key
print(wordcount_map.keys()) # List of keys
print(wordcount_map.values()) # List of values
print("a" in wordcount_map) # True
print(wordcount_map.items()) #prints tuples of key-value pairs
print(wordcount_map["foo"]) # throws a KeyError


###File io
# read line by line
f = open("/tmp/foo.txt","r")
for line in f:
  print line
f.close()

# read the entire file in memory
f = open("/tmp/foo.txt","r")
contents = f.read()
print(contents)
f.close()

# write to a file
f = open("/tmp/bar.txt","r+") # open for both read and write
f.write("This is a test")
contents = f.read()
print(contents) # will print "This is a test"

L5 = L3[1:-1] # L3 from index 1 to (not including) last item.

# but there's a built in function for that! and more!
print(sum(L3)) # sum of all items in L3
print(len(L3)) # length of L3
print(max(L3)) # largest item in L3
print(min(L3)) # smallest item in L3
print(sorted(L3)) # L3 but sorted (smallest to largest)

# testing for membership in list (no need to loop)
print(9 in L3)
print(11 in L3)

### List Comprehensions

print(5/2)  # normal division: 2.5
print(5//2)  # integer division: 2
print(5**2)  # 2 to the power of 3

L = [1, 3, 4, -1, 12, 7, -5, 6]
L2 = sorted(L)
print(L2)  # [-5, -1, 1, 3, 4, 6, 7, 12]
L3 = sorted(L, key=abs)  # using the key abs(), which returns the absolute value of a number

"""
When a variable is reassigned, it stops pointing to the old value, and starts pointing to the new value. A common misconception is that doing x+=2 will add 2 to the value of x, but what happens is actually more complicated. Remember that x+=2 is a shorthand for x = x+2. So when you do x+=2, you’re storing the value of x+2 to x, completely reassigning it. When a variable is reassigned, it stops pointing to the old value, and starts pointing to the new value. A common misconception is that doing x+=2 will add 2 to the value of x, but what happens is actually more complicated. Remember that x+=2 is a shorthand for x = x+2. So when you do x+=2, you’re storing the value of x+2 to x, completely reassigning it.
"""
x = 2
y = x
x+=2
print(y)  # y is still 2, even though x is now 4.

print(sum(nums))  # 6

#Common way to copy a list
print(nums[:])   # Start from the beginning, go to the end 

nums[1:8]=[0]  # Replace items from 1-8 with just a 0

nums = [1, 2, 3]
new = [4, 5, 6]
nums.extend(new)
print(nums)  # [1, 2, 3, 4, 5, 6]

nums = [1, 2, 3, 1, 2, 3]
print(nums.index(2))  # 1

def index_of_first_even(nums):
  for index, num in enumerate(nums):
    if num%2==0: return index
  return -1  # Not found

nums1 = [1, 2, 3]
nums2 = [10, 20, 30]
for n1, n2 in zip(nums1, nums2):
  print(n1+n2)

sums = [n1+n2 for n1, n2 in zip(nums1, nums2)]

#you don’t even need the parentheses
point = 3, 2

#return a tuple of (answer1, answer2)
def complex_function():
  return answer1, answer2

s = "Hello world"
s.upper()
'HELLO WORLD'
s.lower()
'hello world'
s.swapcase()
'hELLO WORLD'
s.replace('o', '0')
'Hell0 w0rld'
s.startswith('Hell')
True
s.title()
'Hello World'

input_str = input("Enter several numbers, separated by spaces: ")
nums = [int(x) for x in input_str.split()]

words = ["Hello", "World"]
combined = " ".join(words)
print(combined)

num = 4
s = f"{num} squared is {num**2}"
print(s)  # 4 squared is 16

num = 4
s = "{} squared is {}".format(num, num**2)
print(s)  # 4 squared is 16

num = 4
s = "%d squared is %f" % num, num**2
print(s)  # 4 squared is 16
