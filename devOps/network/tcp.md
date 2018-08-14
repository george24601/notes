# Handshakes in TCP

why need the third handshake on start?
server side need to ensure that client side received the ACK, i.e., client has been in ESTABLISHED already

why 4 handshakes near the end? Why need time wait

fin -> ack   -> fin -> ack -> (Timed wait). the ack and fin are not merged because server needs to send over all remaining data first, and then can fin and then ACK. Time wait is two 2 max segment lifetime (MSL), so that client can repeat the ack on fin, and ignore remaining data on the network. However, ack and fin may be merged if the server knows no more data is sending to the client 

#TCP congestion control


The listen() function basically sets a flag in the internal socket structure marking the socket as a passive listening socket, one that you can call accept on. It opens the bound port so the socket can then start receiving connections from clients.

The accept() function asks a listening socket to accept the next incoming connection and return a socket descriptor for that connection. So, in a sense,  accept() does create a socket, just not the one you use to listen() for incoming connections on.

TCP tahoe: double frames sent until we reach ssthresh, and after that we just send 1 more than before, to avoid the stampede effect. Once congestion is reached, we will halve the ssthresh.

fast retry: receiving receing later frame, it will instead ack the last one it is expecting, so that sender can immediately resend isntead of waiting after it receives this same frame resp 3 times 

#listening vs accepted

It is all part of the historic setup. listen prepares socket for the next accept call. Listen also allows one to setup the backlog - the number of connections which will be accepted by the system, and than put to wait until your program can really accept them. Everything which comes after the backlog is full well be rejected by the system right away. listen never blocks, while accept will block (unless the socket is in non-blocking mode) until the next connection comes along. Obviously, this does not have to be two separate functions - it is conceivable that accept() function could do everything listen does.

One use case is, for e.g. if you only want to test if a port is still available/and accessible, you can do so by just listening to the port and then closing it without accepting any connections.

Each of these headers contains a bit known as the "reset" (RST) flag. In most packets this bit is set to 0 and has no effect; however, if this bit is set to 1, it indicates to the receiving computer that the computer should immediately stop using the TCP connection; it should not send any more packets using the connection's identifying numbers, called ports, and discard any further packets it receives with headers indicating they belong to that connection.
