
#PID

check /proc/$PID for more info

In Unix-like operating systems, new processes are created by the fork() system call. The PID is returned to the parent enabling it to refer to the child in further function calls. The parent may, for example, wait for the child to terminate with the waitpid() function, or terminate the process with kill().

swapper or sched has process ID 0 and is responsible for paging, and is actually part of the kernel rather than a normal user-mode process. Process ID 1 is usually the init process primarily responsible for starting and shutting down the system.

The normal location for pidfiles is /var/run. Most unices will clean this directory on boot; under Ubuntu this is achieved by /var/run an in-memory filesystem (tmpfs).

If you start your daemon from a script that's running as root, have it create a subdirectory /var/run/gmooredaemon and chown it to the daemon-running user before suing to the user and starting the daemon.

On many modern Linux systems, if you start the daemon from a script or launcher that isn't running as root, you can put the pidfile in /run/user/$UID, which is a per-user equivalent of the traditional /var/run. Note that the root part of the launcher, or a boot script running as root, needs to create the directory (for a human user, the directory is created when the user logs in).

Otherwise, pick a location under /tmp or /var/tmp, but this introduces additional complexity because the pidfile's name can't be uniquely determined if it's in a world-writable directory.


For anything that sources /etc/init.d/functions, the PID will live in /var/run/program_name.pid

when compiling nginx:

```
--pid-path=/var/run/nginx.pid \
--lock-path=/var/lock/nginx.lock \
```

It's a signal to other processes and users of the system that that particular program is running, or at least started successfully.
It allows one to write a script really easy to check if it's running and issue a plain kill command if one wants to end it.
It's a cheap way for a program to see if a previous running instance of it did not exit successfully.

Lock files are used by programs to ensure two (well-behaved) separate instances of a program, which may be running concurrently on one system, don't access something else at the same time. The idea is before the program accesses its resource, it checks for presence of a lock file, and if the lock file exists, either error out or wait for it to go away. When it doesn't exist, the program wanting to "acquire" the resource creates the file, and then other instances that might come across later will wait for this process to be done with it. Of course, this assumes the program "acquiring" the lock does in fact release it and doesn't forget to delete the lock file. (checkout /var/lock)

These files are often used by daemons that should only be run once on a system. The PID file usually contains the process ID number of the already launched and running program if one exists. Also, when it starts up, it creates the lock file. As long as the lock file exists, it won't start another one without user intervention. If the lock file exists and the process id mentioned in the pid file isn't running, the daemon is considered to be in a "dead" state, meaning it's supposed to be running but isn't probably due to a crash or improper shutdown. This might initiate a special startup / restart scenario for some programs. Properly shutting it down will remove the lock file.

Please explain why both a PID file and a lock file would be used. It seems a PID file would be sufficient. If the PID file exists, the PID could be checked to see if the process is running, just takes less steps than check for a lockfile, checking for a PID file, and then verifying the existence of the process. 
To avoid race conditions if nothing else. Some apps have uses for times when the still need the PID but can relinquish the lock. But at a more fundamental level if you overload one file for both operations you open the door to failures such as a crash leaving an inconsistent state on the system.

exec
----------

the exec() system call is used to perform chain loading. The program image of the current process is replaced with an entirely new image, and the current thread begins execution of that image. The common data area comprises data such as the process' environment variables, which are preserved across the system call. This act is also referred to as an overlay
the machine code, data, heap, and stack of the process are replaced by those of the new program. 

A successful overlay destroys the previous memory address space of the process, and all its memory areas, that were not shared, are reclaimed by the operating system. Consequently, all its data that were not passed to the new program, or otherwise saved, become lost.


fork
---------

the copy, called the "child process", calls the exec system call to overlay itself with the other program: it ceases execution of its former program in favor of the other.

After the fork, both processes not only run the same program, but they resume execution as though both had called the system call. They can then inspect the call's return value to determine their status, child or parent, and act accordingly.

The child process starts off with a copy of its parent's file descriptors. For interprocess communication, the parent process will often create a pipe or several pipes, and then after forking the processes will close the ends of the pipes that they don't need

In the child process, the return value of the fork() appears as zero (which is an invalid process identifier). Similarly, why a while fork bomb has exponential growth in processes?

Although all data are replaced, the file descriptors that were open in the parent are closed only if the program has explicitly marked them close-on-exec. This allows for the common practice of the parent creating a pipe prior to calling fork() and using it to communicate with the executed program.


### Zombie Process

Child program terminate, the parent process hasn't read these data yet

a process that has completed execution (via the exit system call) but still has an entry in the process table: it is a process in the "Terminated state". This occurs for child processes, where the entry is still needed to allow the parent process to read its child's exit status: once the exit status is read via the wait system call, the zombie's entry is removed from the process table and it is said to be "reaped".

Also, unlike normal processes, the kill command has no effect on a zombie process.

Zombie processes should not be confused with orphan processes: an orphan process is a process that is still executing, but whose parent has died. These do not remain as zombie processes; instead, (like all orphaned processes) they are adopted by init (process ID 1), which waits on its children. The result is that a process that is both a zombie and an orphan will be reaped automatically.

After the zombie is removed, its process identifier (PID) and entry in the process table can then be reused

Zombies can be identified in the output from the Unix ps command by the presence of a "Z" in the "STAT" column. Can also use pstree or ps -d

To remove zombies from a system, the SIGCHLD signal can be sent to the parent manually, using the kill command. If the parent process still refuses to reap the zombie, and if it would be fine to terminate the parent process, the next step can be to remove the parent process. When a process loses its parent, init becomes its new parent. init periodically executes the wait system call to reap any zombies with init as parent.


# Orphan process

In a Unix-like operating system any orphaned process will be immediately adopted by the special init system process: the kernel sets the parent to init. This operation is called re-parenting and occurs automatically.

It is sometimes desirable to intentionally orphan a process, usually to allow a long-running job to complete without further user attention, or to start an indefinitely running service or agent; such processes (without an associated session) are known as daemons, particularly if they are indefinitely running. A low-level approach is to fork twice, running the desired process in the grandchild, and immediately terminating the child. The grandchild process is now orphaned, and is not adopted by its grandparent, but rather by init. Higher-level alternatives circumvent the shell's hangup handling, either telling the child process to ignore SIGHUP (by using nohup), or removing the job from the job table or telling the shell to not send SIGHUP on session end (by using disown in either case). In any event, the session id (process id of the session leader, the shell) does not change, and the process id of the session that has ended is still in use until all orphaned processes either terminate or change session id (by starting a new session via setsid(2)).


# Daemon
the parent process of a daemon is often, but not always, the init process. A daemon is usually either created by a process forking a child process and then immediately exiting, thus causing init to adopt the child process, or by the init process directly launching the daemon. In addition, a daemon launched by forking and exiting typically must perform other operations, such as dissociating the process from any controlling terminal

Setting the root directory (/) as the current working directory so that the process does not keep any directory in use that may be on a mounted file system (allowing it to be unmounted).

Using a logfile, the console, or /dev/null as stdin, stdout, and stderr

# Kill

The default signal sent is SIGTERM. Programs that handle this signal can do useful cleanup operations (such as saving configuration information to a file) before quitting.

All signals except for SIGKILL and SIGSTOP ("stop") can be "intercepted" by the process, meaning that a special function can be called when the program receives those signals. The two exceptions SIGKILL and SIGSTOP are only seen by the host system's kernel, providing reliable ways of controlling the execution of processes. SIGKILL kills the process, and SIGSTOP pauses it until a SIGCONT ("continue") is received

Essentially, for a process to send a signal to another, the owner of the signaling process must be the same as the owner of the receiving process or be the superuser.

SIGHUP ("signal hang up") is a signal sent to a process when its controlling terminal is closed

If the process receiving SIGHUP is a Unix shell, then as part of job control it will often intercept the signal and ensure that all stopped processes are continued before sending the signal to child processes (more precisely, process groups, represented internally by the shell as a "job"), which by default terminates them

Firstly, the Single UNIX Specification describes a shell utility called nohup, which can be used as a wrapper to start a program and make it ignore SIGHUP by default. Secondly, child process groups can be "disowned" by invoking disown with the job id, which removes the process group from the shell's job table (so they will not be sent SIGHUP), or (optionally) keeps them in the job table but prevents them from receiving SIGHUP on shell termination.

# Job control

when a signal is directed to a process group, the signal is delivered to each process that is a member of the group.

, a session denotes a collection of one or more process groups. A process group is not permitted to migrate from one session to another, and a process may not create a process group that belongs to another session; furthermore, a process is not permitted to join a process group that is a member of another session—that is, a process is not permitted to migrate from one session to another.

When a process replaces its image with a new image (by calling one of the exec functions), the new image is subjected to the same process group (and thus session) membership as the old image.

A single process, the session leader, interacts with the controlling terminal in order to ensure that all programs are terminated when a user "hangs up" the terminal connection. (Where a session leader is absent, the processes in the terminal's foreground process group are expected to handle hangups.)

a "job" is a shell's representation for a process group.

Most tasks (directory listing, editing files, etc.) can easily be accomplished by letting the program take control of the terminal and returning control to the shell when the program exits – formally, by attaching to standard input and standard output to the shell, which reads or writes from the terminal, and catching signals sent from the keyboard, like the termination signal resulting from pressing Control+C.

a single shell command may consist of a pipeline of multiple communicating processes.

The jobs command will list the background jobs existing in the job table, along with their job number and job state (stopped or running)

When a session ends when the user logs out (exits the shell, which terminates the session leader process), the shell process sends SIGHUP to all jobs, and waits for the process groups to end before terminating itself.

In Bash, a program can be started as a background job by appending an ampersand (&) to the command line; its output is directed to the terminal (potentially interleaved with other programs' output), but it cannot read from the terminal input.

the kill builtin (not /bin/kill) can signal jobs by job ID as well as by process group ID – sending a signal to a job sends it to the whole process group, and jobs specified by a job ID should be killed by prefixing "%".

### Green threads

green threads are threads that are scheduled by a runtime library or virtual machine (VM) instead of natively by the underlying operating system. Green threads emulate multithreaded environments without relying on any native OS capabilities, and they are managed in user space instead of kernel space, enabling them to work in environments that do not have native thread support

On a multi-core processor, native thread implementations can automatically assign work to multiple processors, whereas green thread implementations normally cannot

Green threads significantly outperform Linux native threads on thread activation and synchronization.
Linux native threads have slightly better performance on I/O and context switching operations.

When a green thread executes a blocking system call, not only is that thread blocked, but all of the threads within the process are blocked

To avoid that problem, green threads must use asynchronous I/O operations, although the increased complexity on the user side can be reduced if the virtual machine implementing the green threads spawns specific I/O processes (hidden to the user) for each I/O operation
