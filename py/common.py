hash = {}
  hash['word'] = 'garfield'
  hash['count'] = 42
  s = 'I want %(count)d copies of %(word)s' % hash  # %d for int, %s for string

  del list[0]     ## Delete first element
  del list[-2:]   ## Delete last two elements


  # Split the line into chunks, which are concatenated automatically by Python
  text = (
    "%d little pigs come out, "
    "or I'll %s, and I'll %s, "
    "and I'll blow your %s down."
    % (3, 'huff', 'puff', 'house'))


# Without newline
print("Hello World", end='')

#scala style yield is possible, called generator here

#all input is just gotten from the input() function, which you do not need to import. As a parameter to the input function, you give the prompt for the user.
print("Name is ", name ," and age is ", age)

#Merging dictionaries
x = {'a': 1, 'b': 2}
y = {'b': 3, 'c': 4}
z = {**x, **y}

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

# but there's a built in function for that! and more!
print(sum(L3)) # sum of all items in L3
print(len(L3)) # length of L3
print(max(L3)) # largest item in L3
print(min(L3)) # smallest item in L3
print(sorted(L3)) # L3 but sorted (smallest to largest)

# testing for membership in list (no need to loop)
print(9 in L3)
print(11 in L3)

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

list.extend(list2) # adds the elements in list2 to the end of the list. Using + or += on a list is similar to using extend().
list.index(elem) # searches for the given element from the start of the list and returns its index. Throws a ValueError if the element does not appear (use "in" to check without a ValueError).
list.remove(elem) # searches for the first instance of the given element and removes it (throws ValueError if not present)
list.sort() # sorts the list in place (does not return it). (The sorted() function shown later is preferred.)
list.reverse() # reverses the list in place (does not return it)
new_grades = [x+10 for x in grades]

even_nums = [x for x in nums if x%2==0]


