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


