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

A successful call to epoll_create( ) instantiates a new epoll instance, and returns a file descriptor associated with the instance. This file descriptor has no relationship to a real file; it is just a handle to be used with subsequent calls using the epoll facility. The size parameter is a hint to the kernel about the number of file descriptors that are going to be monitored; it is not the maximum number. Passing in a good approximation will result in better performance

A successful call to epoll_ctl( ) controls the epoll instance associated with the file descriptor epfd. The parameter op specifies the operation to be taken against the file associated with fd. The event parameter further describes the behavior of the operation.

struct epoll_event {
        _  _u32 events;  /* events */
        union {
                void *ptr;
                int fd;
                _  _u32 u32;
                _  _u64 u64;
        } data;
};

A call to epoll_wait( ) waits up to timeout milliseconds for events on the files associated with the epoll instance epfd. Upon success, events points to memory containing epoll_event structures describing each event, up to a maximum of maxevents events. The return value is the number of events, or −1 on error, in which case errno is set to one of the following

select uses a linear search through the list of watched file descriptors, which causes its O(n) behaviour, whereas epoll uses callbacks in the kernel file structure.

nother fundamental difference of epoll is that it can be used in an edge-triggered, as opposed to level-triggered, fashion. This means that you receive “hints” when the kernel believes the file descriptor has become ready for I/O, as opposed to being told “I/O can be carried out on this file descriptor”

It differs both from poll and select in such a way that it keeps the information about the currently monitored descriptors and associated events inside the kernel, and exports the API to add/remove/modify those.
