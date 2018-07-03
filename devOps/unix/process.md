zombie process - child program terminate, the parent process hasn't read these data yet

what is a daemon process, difference between daemon and normal process

PID
--------
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


zombie process
--------
a process that has completed execution (via the exit system call) but still has an entry in the process table: it is a process in the "Terminated state". This occurs for child processes, where the entry is still needed to allow the parent process to read its child's exit status: once the exit status is read via the wait system call, the zombie's entry is removed from the process table and it is said to be "reaped".

Also, unlike normal processes, the kill command has no effect on a zombie process.

Zombie processes should not be confused with orphan processes: an orphan process is a process that is still executing, but whose parent has died. These do not remain as zombie processes; instead, (like all orphaned processes) they are adopted by init (process ID 1), which waits on its children. The result is that a process that is both a zombie and an orphan will be reaped automatically.

After the zombie is removed, its process identifier (PID) and entry in the process table can then be reused

Zombies can be identified in the output from the Unix ps command by the presence of a "Z" in the "STAT" column. Can also use pstree or ps -d

To remove zombies from a system, the SIGCHLD signal can be sent to the parent manually, using the kill command. If the parent process still refuses to reap the zombie, and if it would be fine to terminate the parent process, the next step can be to remove the parent process. When a process loses its parent, init becomes its new parent. init periodically executes the wait system call to reap any zombies with init as parent.


Orphan process
-------

In a Unix-like operating system any orphaned process will be immediately adopted by the special init system process: the kernel sets the parent to init. This operation is called re-parenting and occurs automatically.

It is sometimes desirable to intentionally orphan a process, usually to allow a long-running job to complete without further user attention, or to start an indefinitely running service or agent; such processes (without an associated session) are known as daemons, particularly if they are indefinitely running. A low-level approach is to fork twice, running the desired process in the grandchild, and immediately terminating the child. The grandchild process is now orphaned, and is not adopted by its grandparent, but rather by init. Higher-level alternatives circumvent the shell's hangup handling, either telling the child process to ignore SIGHUP (by using nohup), or removing the job from the job table or telling the shell to not send SIGHUP on session end (by using disown in either case). In any event, the session id (process id of the session leader, the shell) does not change, and the process id of the session that has ended is still in use until all orphaned processes either terminate or change session id (by starting a new session via setsid(2)).


Daemon
--------
the parent process of a daemon is often, but not always, the init process. A daemon is usually either created by a process forking a child process and then immediately exiting, thus causing init to adopt the child process, or by the init process directly launching the daemon. In addition, a daemon launched by forking and exiting typically must perform other operations, such as dissociating the process from any controlling terminal

Setting the root directory (/) as the current working directory so that the process does not keep any directory in use that may be on a mounted file system (allowing it to be unmounted).

Using a logfile, the console, or /dev/null as stdin, stdout, and stderr
