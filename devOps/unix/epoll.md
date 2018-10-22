Whenever your process enters the select(), the kernel must iterate through the passed file descriptors, check their state and register callbacks. Then when an event on any of the fd's happens, the kernel must iterate again to deregister the callbacks. Basically on the kernel side entering and exiting select() is a heavyweight operation, requiring touching many pointers, thrashing processor cache, and there is no way around it.

Epoll() is Linux's solution. With it the developer can avoid constantly registering and de-registering file descriptors. This is done by explicitly managing the registrations with the epoll_ctl syscall.

problem of the kernel dispatch time being a costly O(N) on the number of processes / descriptors

This is because "level triggered" (aka: normal) epoll inherits the "thundering herd" semantics from select(). Without special flags, in level-triggered mode, all the workers will be woken up on each and every new connection. Here's an example:

Kernel: Receives a new connection.
Kernel: Notifies two waiting threads A and B. Due to "thundering herd" behavior with level-triggered notifications kernel must wake up both.
Thread A: Finishes epoll_wait().
Thread B: Finishes epoll_wait().
Thread A: Performs accept(), this succeeds.
Thread B: Performs accept(), this fails with EAGAIN.

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

The best and the only scalable approach is to use recent Kernel 4.5+ and use level-triggered events with EPOLLEXCLUSIVE flag. This will ensure only one thread is woken for an event, avoid "thundering herd" issue and scale properly across multiple CPU's

Say you're writing from a resource to an FD. If you register your interest for that FD becoming write ready as level-triggered, you'll get constant notification that the FD is still ready for writing. If the resource isn't yet available, that's a waste of a wake-up, because you can't write any more anyway.

If you were to add it as edge-triggered instead, you'd get notification that the FD was write ready once, then when the other resource becomes ready you write as much as you can. Then if write(2) returns EAGAIN, you stop writing and wait for the next notification.

The same applies for reading, because you might not want to pull all the data into user-space before you're ready to do whatever you want to do with it (thus having to buffer it, etc etc). With edge-triggered epoll you get told when it's ready to read, and then can remember that and do the actual reading "as and when".

Use level trigger mode when you can't consume all the data in the socket/file descriptor and want epoll to keep triggering while data is available. Otherwise epoll will not return again and your network stack may freeze (depending on your implementation).

Typically one wants to use edge trigger mode and make sure all data available is buffered and will be handled eventually.

### another blog

Every time you accept a connection with the accept system call, you get a new file descriptor representing that connection.

instead of checking all, wait for the notification from unix

poll and select fundamentally use the same code.

poll returns a larger set of possible results for file descriptors like POLLRDNORM | POLLRDBAND | POLLIN | POLLHUP | POLLERR while select just tells you “there’s input / there’s output / there’s an error”.

poll can perform better than select if you have a sparse set of file descriptors

With poll, you tell it “here are the file descriptors I want to monitor: 1, 3, 8, 19, etc” (that’s the pollfd argument. With select, you tell it “I want to monitor 19 file descriptors. Here are 3 bitsets with which ones to monitor for reads / writes / exceptions.” So when it runs, it loops from 0 to 19 file descriptors, even if you were actually only interested in 4 of them.

On each call to select() or poll(), the kernel must check all of the specified file descriptors to see if they are ready. When monitoring a large number of file descriptors that are in a densely packed range, the timed required for this operation greatly outweights [the rest of the stuff they have to do]

Basically there are 2 ways to get notifications

get a list of every file descriptor you’re interested in that is readable (“level-triggered”)
get notifications every time a file descriptor becomes readable (“edge-triggered”)

The epoll group of system calls (epoll_create, epoll_ctl, epoll_wait) give the Linux kernel a list of file descriptors to track and ask for updates about whether

Call epoll_create to tell the kernel you’re gong to be epolling! It gives you an id back

Call epoll_ctl to tell the kernel file descriptors you’re interested in updates about. Interestingly, you can give it lots of different kinds of file descriptors (pipes, FIFOs, sockets, POSIX message queues, inotify instances, devices, & more)

Call epoll_wait to wait for updates about the list of files you’re interested in.
