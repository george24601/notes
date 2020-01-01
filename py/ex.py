#!/usr/bin/env python

import sys

def main():
    print 'Hello there', sys.argv[1]

import math
print('The value of PI is approximately {0:.3f}.'.format(math.pi))

#formatting examples
print('We are the {} who say "{}!"'.format('knights', 'Ni'))

print('This {food} is {adjective}.'.format(food='spam', adjective='absolutely horrible'))

def exp_backoff():
  good = op()
  attempt = 1
  slot = 0.5
  #note that in the class algo, on the first failure, we will wait 0 or 1 slot times
  while not good:
      time.sleep(power(2, random(attempt - 1)) * slot))
      good = op()
      attempt += 1

