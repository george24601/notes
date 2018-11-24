NIO data transfer is based on buffers (java.nio.Buffer and related classes). These classes represent a contiguous extent of memory, together with a small number of data transfer operations.

Typically, this would be used to allow the buffer contents to occupy the same physical memory used by the underlying operating system for its native I/O operations, thus allowing the most direct transfer mechanism, and eliminating the need for any additional copying. In most operating systems, provided the particular area of memory has the right properties, transfer can take place without using the CPU at all.

Channels (classes implementing the interface java.nio.channels.Channel) are designed to provide for bulk data transfers to and from NIO buffers.Channels are analogous to "file descriptors" found in Unix-like operating systems.

File channels (java.nio.channels.FileChannel) can use arbitrary buffers but can also establish a buffer directly mapped to file contents using memory-mapped file. They can also interact with file system locks. Similarly, socket channels (java.nio.channels.SocketChannel and java.nio.channels.ServerSocketChannel) allow for data transfer between sockets and NIO buffers.

A selector (java.nio.channels.Selector and subclasses) provides a mechanism for waiting on channels and recognizing when one or more become available for data transfer.

A buffer is a container for a fixed amount of data of a specific primitive type. In addition to its content a buffer has a position, which is the index of the next element to be read or written, and a limit, which is the index of the first element that should not be read or written.

Byte buffers are distinguished in that they can be used as the sources and targets of I/O operations. They also support several features not found in the other buffer classes

A byte buffer can be allocated as a direct buffer, in which case the Java virtual machine will make a best effort to perform native I/O operations directly upon it

A byte buffer can be created by mapping a region of a file directly into memory, in which case a few additional file-related operations defined in the MappedByteBuffer class are available.

t IO is stream oriented, where NIO is buffer oriented.

What you do with the read bytes is up to you. They are not cached anywhere. Furthermore, you cannot move forth and back in the data in a stream. If you need to move forth and back in the data read from a stream, you will need to cache it in a buffer first

you need to make sure that when reading more data into the buffer, you do not overwrite data in the buffer you have not yet processed.

A channel is like a stream. It represents a connection between a data source/sink and a Java program for data transfer.

Java NIO’s selectors allow a single thread to monitor multiple channels of input. You can register multiple channels with a selector, then use a single thread to “select” the channels that have input available for processing, or select the channels that are ready for writing. This selector mechanism makes it easy for a single thread to manage multiple channels.

Reading from a channel is simple: we simply create a buffer and then ask a channel to read data into it. Writing is also fairly simply: we create a buffer, fill it with data, and then ask a channel to write from it.

java.net will require one thread per socket.

There are four different events we can listen for, each is represented by a constant in the SelectionKey class:

Connect – when a client attempts to connect to the server. Represented by SelectionKey.OP_CONNECT
Accept – when the server accepts a connection from a client. Represented by SelectionKey.OP_ACCEPT
Read – when the server is ready to read from the channel. Represented by SelectionKey.OP_READ
Write – when the server is ready to write to the channel. Represented by SelectionKey.OP_WRITE

The ready set defines the set of events that the channel is ready for. It is an integer value as well;

ByteBuffer's allocateDirect allocates native memory

