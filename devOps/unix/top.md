CPU States
--------
us, user: it shows us that the processor is spending 1.8% of its time running user space processes. A user space program is any process that does not belong to the kernel. note its nice v < 0


id, idle: it tells us that the processor was idle just over 97% of the time during the last sampling period.

wa: idle wait io

ni: high nice value user space process

Memory
-------
Swap is virtual memory which can be a file or a partition on your hard drive that is essentially used as extra RAM

Tasks
-------
PR: it is the process actual priority, as viewed by the Linux kernel, the scheduling priority of the process. For normal processes, the kernel priority is simply +20 from the nice value. Thus a process with the neutral nice value of zero has a kernel priority of 20. For processes running under real-time, the value of the field is RT

VIRT: It is the amount of virtual memory used by the process. It represents how much memory the program is able to access at the present moment; it stands for the virtual size of a process, which is the sum of memory it is actually using

RES: It is the resident memory size. Resident memory is the amount of non-swapped physical memory a task is using. It stands for the resident size, which is an accurate representation of how much actual physical memory a process is consuming. (This also corresponds directly to the %MEM column.)

SHR: SHR is the shared memory used by the process and it indicates how much of the VIRT size is actually sharable (memory or libraries). In the case of libraries, it does not necessarily mean that the entire library is resident.

%MEM: It represents the percentage of available physical memory used by the process.

TIME+: The total CPU time the task has used since it started, with precision up to hundredth of a second.

COMMAND: The command which was used to start the process

Alternate Display Mode
--------
can be entered into using the A display mode toggle command
You can switch between 4 windows with a and w keys. a moves to next and w to previous window. With g command, you can enter a number to select the current window.

Pressing R shall reverse the sorting order of the currently sorted column

c displays the full command path along with the command line arguments in the COMMAND column.

V key will display the processes in a parent-child hierarchy as below

u shows processes for a particular user. You are prompted to enter the username. Blank will show for all users. It displays only processes with a user id or user name matching that given,  matches on effective user

k is used to send signals to tasks (Usually kill tasks). You will be prompted for a PID and then the signal to send. Entering no PID or a negative number will be interpreted as the default shown in the prompt (the first task displayed). A PID value of zero means the top program itself. The default signal, as reflected in the prompt, is SIGTERM.

cache is page cache in memory
cache for file system I/O
also used as other deviced's cache, e..g, block device
buffer cache is for block device IO -, also memmroy managed by block

# of online customers is more straightforward, # of concurent request is more accurate

```bash

#check memory, unit kb, buffter is buffer cache in memory, 
free

top -p pid_value

top -u franshesco

#sort by %CPU
top -o %CPU

pmap -x [pid]
```


