def exp_backoff():
  good = op()
  attempt = 1
  slot = 0.5
  #note that in the class algo, on the first failure, we will wait 0 or 1 slot times
  while not good:
      time.sleep(power(2, random(attempt - 1)) * slot))
      good = op()
      attempt++
