/boot - bootstrap related - don't touch it!

/var is a standard subdirectory that contains files to which the system writes data during the course of its operation.

/usr, which is generally the largest directory (at least on a newly installed system) and is used to store application programs, should only contain static data.

/var/lib (contains dynamic data libraries and files), 

/var/lock (contains lock files created by programs to indicate that they are using a particular file or device),

/var/log (contains log files),

The .d suffix here means directory. the goal is to avoid name clashing, not between the executable and the configuration file but between the former monolithic configuration file and the directory containing them.

/etc Contains system-wide configuration files and system databases;

/proc/net/, a directory containing useful information about the network stack, in particular /proc/net/nf_conntrack, which lists existing network connections (particularly useful for tracking routing when iptables FORWARD is used to redirect network connections)

The /dev directory contains the special device files for all the devices. The device files are created during installation,

/dev/hda is the master IDE drive on the primary IDE controller. /dev/hdb the slave drive on the primary controller. /dev/hdc , and /dev/hdd are the master and slave devices on the secondary controller respectively

/dev/null This can be useful if, for example, you wish to run a command but not have any feedback appear on the terminal.

/dev/random is a non-deterministic generator which means that the value of the next number cannot be guessed from the preceding ones. It uses the entropy of the system hardware to generate numbers. When it has no more entropy to use then it must wait until it has collected more before it will allow any more numbers to be read from it.

/opt is used to install 'self-contained' applications,or you compile from source code. Using /opt/my_app/etc/ for config files, /opt/my_app/log/ for logs - or put it in /opt/bin and /opt/lib

/sbin - super user bin

/srv - server data

# procfs
mapped to virtual memory

# tmpfs
use tmpfs by default for the /tmp branch of the file system or for shared memory.

It is intended to appear as a mounted file system, but stored in volatile memory instead of a persistent storage device. A similar construction is a RAM disk, which appears as a virtual disk drive and hosts a disk file system.

Everything stored in tmpfs is temporary in the sense that no files will be created on the hard drive; however, swap space is used as backing store in case of low memory situations.

?ln -s , mv, how do they affect inode and block?


Mount
--------
makes files and directories on a storage device (such as hard drive, CD-ROM, or network share) available for user to access via the computer's file system

The exact location in VFS that the newly-mounted medium got registered is called mount point; when the mounting process is completed, the user can access files and directories on the medium from there.

Normally, when the computer is shutting down, every mounted storage will undergo an unmounting process to ensure that all queued data got written, and to preserve integrity of file system structure on the media.

A file system can be defined as user mountable in the /etc/fstab file by the root user.


#File descriptor
an abstract indicator (handle) used to access a file or other input/output resource, such as a pipe or network socket

0 - stdin, 1 - stdout, 2 - stderr

file descriptors index into a per-process file descriptor table maintained by the kernel, that in turn indexes into a system-wide table of files opened by all processes, called the file table. This table records the mode with which the file (or other resource) has been opened: for reading, writing, appending, and possibly other modes. It also indexes into a third table called the inode table that describes the actual underlying files.[3] To perform input or output, the process passes the file descriptor to the kernel through a system call, and the kernel will access the file on behalf of the process. The process does not have direct access to the file or inode tables.

set of file descriptors open in a process can be accessed under the path /proc/PID/fd/, where PID is the process identifier.

In Unix-like systems, file descriptors can refer to any Unix file type named in a file system. As well as regular files, this includes directories, block and character devices (also called "special files"), Unix domain sockets, and named pipes. File descriptors can also refer to other objects that do not normally exist in the file system, such as anonymous pipes and network sockets.

# inode

Each inode stores the attributes and disk block location(s) of the object's data.[1] Filesystem object attributes may include metadata (times of last change,[2] access, modification), as well as owner and permission data.[3]

Directories are lists of names assigned to inodes. A directory contains an entry for itself, its parent, and each of its children.

On many types of file system implementations, the maximum number of inodes is fixed at file system creation, limiting the maximum number of files the file system can hold. A typical allocation heuristic for inodes in a file system is one percent of total size.

The inode number indexes a table of inodes in a known location on the device

A file's inode number can be found using the ls -i command. The ls -i command prints the i-node number in the first column of the report.


