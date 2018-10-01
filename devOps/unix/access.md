DAC: process has the same access as the user who excutes it

/etc/passwd and /etc/group for user and group info. etc/shadow

#File types
Directory, Link, Socket, Char device, Pipe, - other, e.g., normal file 

1. normal file : txt and binary, can be created by touch

2. socket byte file: for network communication, nromally created program during execution

3. named pipe file: mkfifo

4. char file and block file -device file: 

soft link file


top - 
UID: effective user id
GID: effective group id
ruid: real user id, user who created this process, when he logs into the system

# how sudo works
/etc/sudoers 

root ALL=(ALL) ALL - The root user can execute from ALL terminals, acting as ALL (any) users, and run ALL (any) command.

operator ALL= /sbin/poweroff - the user operator can from any terminal, run the command power off

why everyone can write file and create dir to /tmp, but can only write and delete their own file or dir?


for dir, r reads ls, w makes create/delete files under the dir, x means can cd into dir


