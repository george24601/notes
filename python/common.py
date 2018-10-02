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

#Tuples are immutable, and usually contain a heterogeneous sequence of elements that are accessed via unpacking (see later in this section) or indexing (or even by attribute in the case of namedtuples). Lists are mutable, and their elements are usually homogeneous and are accessed by iterating over the list.
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

mylist = [1,2,3]
foo(*mylist)

mydict = {'x':1,'y':2,'z':3}
foo(**mydict)

"""


# You can also add new items at the end of the list, by using the append() method

#To loop over two or more sequences at the same time, the entries can be paired with the zip() function.

#To loop over a sequence in reverse, first specify the sequence in a forward direction and then call the reversed() function.

#To loop over a sequence in sorted order, use the sorted() function which returns a new sorted list while leaving the source unaltered.


