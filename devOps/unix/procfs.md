/proc/PID/cmdline, the command that originally started the process.

/proc/PID/maps, a text file containing information about mapped files and blocks (like heap and stack).

/proc/PID/environ contains the names and values of the environment variables that affect the process.


/proc/crypto, a list of available cryptographic modules

/proc/meminfo, containing a summary of how the kernel is managing its memory.

/proc/net/, a directory containing useful information about the network stack, in particular /proc/net/nf_conntrack, which lists existing network connections (particularly useful for tracking routing when iptables FORWARD is used to redirect network connections)

/proc/swaps, a list of the active swap partitions, their various sizes and priorities

/proc/sysvipc, containing memory-sharing and inter-process communication (IPC) information.

/proc/version, containing the Linux kernel version, distribution number, gcc version number (used to build the kernel) and any other pertinent information relating to the version of the kernel currently running

use /proc/<pid>/oom_adj to set how system choose which process to kill

#process's memory usage
/proc/PID/status contains basic information about a process including its run state and memory usage.
VmRSS - physical memory size
VmStk
VmExe 
VmLib - 

RSZ: resident set size: process's actual physcial memory size

for non-parallel systems, throughput and latency are in reverse


/proc/interrupt

cat /proc/$(pidof accept.out)/stack

/proc/<pid>/limits - this process's limit

information about active sockets under three different files:  /proc/<pid>/net/tcp, /proc/<pid>/fd, and /proc/<pid>/net/sockstat.

While the fd directory presents us a list of files opened by the process,  /proc/<pid>/net/tcp file gives us information regarding currently active TCP connections (in their various states) under the process network namespace.  sockstat, on the other hand, acts more like a summary.
