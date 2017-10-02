Its function is to monitor multiple file descriptors to see if I/O is possible on any of them. It is meant to replace the older POSIX select(2) and poll(2) system calls

to achieve better performance in more demanding applications, where the number of watched file descriptors is large (unlike the older system calls, which operate in O(n) time, epoll operates in O(1) time

in that it consists of a set of user space functions, each taking a file descriptor argument denoting the configurable kernel object against which they cooperatively operate.

int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
Controls (configures) which file descriptors are watched by this object, and for which events. op can be ADD, MODIFY or DELETE.

int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
Waits for any of the events registered for with epoll_ctl, until at least one occurs or the timeout elapses. Returns the occurred events in events, up to maxevents at once.

On each call to select() or poll(), the kernel must check all of the specified file descriptors to see if they are ready. When monitoring a large number of file descriptors that are in a densely packed range, the timed required for this operation greatly outweights [the rest of the stuff they have to do

The kernel doesn’t remember the list of file descriptors it’s supposed to be monitoring!

level-triggered:get a list of every file descriptor you’re interested in that is readable 
edge-triggered: get notifications every time a file descriptor becomes readable

Call epoll_create to tell the kernel you’re gong to be epolling! It gives you an id back

all epoll_ctl to tell the kernel file descriptors you’re interested in updates about. Interestingly, you can give it lots of different kinds of file descriptors (pipes, FIFOs, sockets, POSIX message queues, inotify instances, devices, & more), but not regular files

Call epoll_wait to wait for updates about the list of files you’re interested in.

th poll( ) and select( ) (discussed in Chapter 2) require the full list of file descriptors to watch on each invocation. The kernel must then walk the list of each file descriptor to be monitored. When this list grows large—it may contain hundreds or even thousands of file descriptors—walking the list on each invocation becomes a scalability bottleneck.

Epoll circumvents this problem by decoupling the monitor registration from the actual monitoring. One system call initializes an epoll context, another adds monitored file descriptors to or removes them from the context, and a third performs the actual event wait.
