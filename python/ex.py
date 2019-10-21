#!/usr/bin/env python

import sys

def main():
    print 'Hello there', sys.argv[1]

# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()

import math
print('The value of PI is approximately {0:.3f}.'.format(math.pi))

#Initialising a list filled with some number
[0]*1000 # List of 1000 zeros

#formatting examples
print('We are the {} who say "{}!"'.format('knights', 'Ni'))

print('This {food} is {adjective}.'.format(food='spam', adjective='absolutely horrible'))

2 ** 10 = 1024

def exp_backoff():
  good = op()
  attempt = 1
  slot = 0.5
  #note that in the class algo, on the first failure, we will wait 0 or 1 slot times
  while not good:
      time.sleep(power(2, random(attempt - 1)) * slot))
      good = op()
      attempt += 1

