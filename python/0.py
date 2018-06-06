squares = [1, 4, 9, 16, 25] #note it is curly braces in cpp

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


#If you need to modify the sequence you are iterating over while inside the loop (for example to duplicate selected items), it is recommended that you first make a copy. Iterating over a sequence does not implicitly make a copy.

for w in words[:]:  # Loop over a slice copy of the entire list.
     if len(w) > 6:
        words.insert(0, w)

range(0, 10, 3)

a = ['Mary', 'had', 'a', 'little', 'lamb']
for i in range(len(a)):
    print(i, a[i])


#A tuple consists of a number of values separated by commas
t = 12345, 54321, 'hello!'

u = t, (1, 2, 3, 4, 5) #((12345, 54321, 'hello!'), (1, 2, 3, 4, 5))
#Note that tuple uses (, list [ in py, and { in cpp 

tel = {'jack': 4098, 'sape': 4139}

'guido' in tel

'jack' not in tel


del tel['sape']

#formatting examples
print('We are the {} who say "{}!"'.format('knights', 'Ni'))

print('This {food} is {adjective}.'.format(food='spam', adjective='absolutely horrible'))

import math
print('The value of PI is approximately {0:.3f}.'.format(math.pi))

