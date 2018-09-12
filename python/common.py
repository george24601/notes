# replace some values
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
for key, value in m.iteritems():
    print('{0}: {1}'.format(key, value))

#Iterating over list values while getting the index too
m = ['a', 'b', 'c', 'd']
for index, value in enumerate(m):
    print('{0}: {1}'.format(index, value))


#Initialising empty containers
a_list = list()
a_dict = dict()
a_map = map()
a_set = set()

#multiple assignment & with tuple
a,b,c=3,4,5
my_tuple=3,4,5
x,y,z=my_tuple


