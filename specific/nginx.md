even sender: sends IO event to event processor
event collector: collect worker process's IO request
event collector: respond to events

for every client request, master process will gen a worker process. woekr process will be killed once connection is over

after master process starts, uses a for loop to accept and process external signals, 

master porcess fork() woker child process, every child process uses a for loop to accept and process event, worker # should be roughly sames as CPU cores

master will create socket to listen to before the fork

all worker process's listenfd will become readacle , and they will fight for accept_mustex, the winner register listenfd read event, and inside it accept() the conntection

master and woerker's interacttion uses pipe implemented by socket, master -> worker single way  inlcuduing command, and woker process id
master process communicates with outside via signal

communication between workers are done via master indirection: find the process id, and then write the command to the pipe pointing to W2
