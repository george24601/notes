#!/bin/bash

VENV_BIN=venv/bin
python3 -m venv venv
$(VENV_BIN)/pip install --upgrade pip
$(VENV_BIN)/pip install -r requirements.txt

#by default locust reads the locustfile.py
locust --headless --users 1 --spawn-rate 1 -H http://your-server.com

#To run Locust distributed across multiple processes we would start a master process by specifying --master:
locust -f locust_files/my_locust_file.py --master --host=http://example.com

#and then we would start an arbitrary number of slave processes:
locust -f locust_files/my_locust_file.py --slave --host=http://example.com

#-c specifies the number of Locust users to spawn, and -r specifies the hatch rate (number of users to spawn per second)
#--run-time 1h30m
locust -f locust_files/my_locust_file.py --no-web -c 1000 -r 100

#The files will be named example_distribution.csv and example_requests.csv
locust -f examples/basic.py --csv=example --no-web -t10m

locust -f stg_l_p2p.py --master

locust -f stg_l_p2p.py --slave --master-host=0.0.0.0
