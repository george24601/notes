#install PIP
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

#create a virtual environment, decide upon a directory where you want to place it, and run the venv module as a script with the directory path:
python3 -m venv tutorial-env

#active it
source tutorial-env/bin/activate
