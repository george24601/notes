DAC: process has the same access as the user who excutes it

/etc/passwd and /etc/group for user and group info. etc/shadow

file types:

normal file : txt and binary, can be created by touch

socket byte file: for network communication, nromally created program during execution

named pipe file: mkfifo

char file and block file -device file: 

soft link file

Acess control group: user/ group/ others
r, w, x,s,t

ls -l - first char is file type, then owner, group, others access, 3 chars for each case

top - 
UID: effective user id
GID: effective group id
ruid: real user id, user who created this process, when he logs into the system

how sudo works

why everyone can write file and create dir to /tmp, but can only write and delete their own file or dir


for dir, r reads ls, w makes create/delete files under the dir, x means can cd into dir


