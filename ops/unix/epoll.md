select(): add the thread to each socket it is listening to's wait list, when a message arrives at one socket, remove them fromt hese wait list, and add to the worker queue, select it self is blocking
epoll(): use epoll_ctl to maintin the waiting queue, use epoll_wait to block the process. Use a separate rdlist to maintain what sockets ahve the data
IO reused: select + poll, when the kernel finds that process's i/o condition is satisfied, call the process
select() and poll() are blocking themselves, when the socket reports readable, it will read by the recform

creates eventpoll object, similar to socket, adds it to the socket's waitlist. Every time socket receives data, kernel adds socket ref to the eventpoll's readlist

epoll_wait() will add the treadh to eventpoll's waitlist and block it. When the socket receives data, interuptro will modify the rdlist and wake up threads on the eventpoll

aysnc IO: signal based IO tells when we are START reading, async model tells us when IO can be completed!

edge-triggered()

Kernel: Receives first connection. Two threads, A and B, are waiting. Due to "edge triggered" behavior only one is notified - let's say thread A.
Thread A: Finishes epoll_wait().
Thread A: Performs accept(), this succeeds.
Kernel: The accept queue is empty, the event-triggered socket moved from "readable" to "non readable", so the kernel must re-arm it.
Kernel: Receives a second connection.
Kernel: Only one thread is currently waiting on the epoll_wait(). Kernel wakes up Thread B.
Thread A: Must perform accept() since it does not know if kernel received one or more connections originally. It hopes to get EAGAIN, but gets another socket.
Thread B: Performs accept(), receives EAGAIN. This thread is confused.
Thread A: Must perform accept() again, gets EAGAIN.


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
