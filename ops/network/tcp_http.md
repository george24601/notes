The listen() function basically sets a flag in the internal socket structure marking the socket as a passive listening socket, one that you can call accept on. It opens the bound port so the socket can then start receiving connections from clients.

The accept() function asks a listening socket to accept the next incoming connection and return a socket descriptor for that connection. So, in a sense,  accept() does create a socket, just not the one you use to listen() for incoming connections on.

###listening vs accepted

It is all part of the historic setup. listen prepares socket for the next accept call. Listen also allows one to setup the backlog - the number of connections which will be accepted by the system, and than put to wait until your program can really accept them. Everything which comes after the backlog is full well be rejected by the system right away. listen never blocks, while accept will block (unless the socket is in non-blocking mode) until the next connection comes along. Obviously, this does not have to be two separate functions - it is conceivable that accept() function could do everything listen does.

One use case is, for e.g. if you only want to test if a port is still available/and accessible, you can do so by just listening to the port and then closing it without accepting any connections.

Each of these headers contains a bit known as the "reset" (RST) flag.  if this bit is set to 1, it indicates to the receiving computer that the computer should immediately stop using the TCP connection; it should not send any more packets using the connection's identifying numbers, called ports, and discard any further packets it receives with headers indicating they belong to that connection, i.e., reset by peer

### tcp status
* LISTENING: listen to connection request from remote TCP port server has to open a socket and listen to it 
* SYN-SENT: client side, after SYN is sent, if good, it becomes ESTABLISHED, normally SYN-SENT should be quick
* SYN-RCVD: server side, after ACK+SYN is sent, similar to SYN-SENT, should be very quick to change to ESTABLISHED. Note if you have many SYN-RCVD, maybe a sign of SYN flood DDoS. Connection is now to half-opened state inside the half-connection queue 
* ESTABLISHED: full conneciton queue: not ACCEPTED by the apply, will have packet loss if they are full 
* FIN-WAIT-1: active close side, after FIN is sent, includes a current serial number K, and include an ACK to confirm have received the the latest data
* CLOSE_WAIT: 
* FIN-WAIT-2: after the active close side receives ACK 
* CLOSING: rare
* LAST-ACK: passive close side, the program received to EOF to call CLOSE, PCS will send a FIN and wait for ACK, e.g., when disconnect stress testing client, you will see many LAST-ACK
* TIME_WAIT: waits 2 MSL so that 1. make sure the last ack from client is received, and no retry comes from server (if there is, we reset the 2MSL timer). All ongoing datagrams will be expired when the new connections tarts with the same port. Note that Scoket/port is sitll occupied at this state

On server receiving SYN, needs to ACK + SYN back to the client to ensure the new connection is not some stale packet. Client set will SEQ NO  = ISN + 1, normally ISN is randomized by time clock + 32 bit counter - a lot of ISN gen details

Note that both client and server have a separate ISN

timer: every conneciton has one

max window size 16bit = 65535


### http

Http partial request and 206 response


WebSocket "is designed to work over HTTP ports 80 and 443 as well as to support HTTP proxies and intermediaries" thus making it compatible with the HTTP protocol. To achieve compatibility, the WebSocket handshake uses the HTTP Upgrade header[1] to change from the HTTP protocol to the WebSocket protocol.

providing a standardized way for the server to send content to the client without being first requested by the client, and allowing messages to be passed back and forth while keeping the connection open. In this way, a two-way ongoing conversation can take place between the client and the server.

To establish a WebSocket connection, the client sends a WebSocket handshake request, for which the server returns a WebSocket handshake response,

In addition to Upgrade headers, the client sends a Sec-WebSocket-Key header containing base64-encoded random bytes, and the server replies with a hash of the key in the Sec-WebSocket-Accept header. This is intended to prevent a caching proxy from re-sending a previous WebSocket conversation, and does not provide any authentication, privacy or integrity.

It is important (from a security perspective) to validate the "Origin" header during the connection establishment process on the server side (against the expected origins) to avoid Cross-Site WebSocket Hijacking attacks, which might be possible when the connection is authenticated with Cookies or HTTP authentication. It is better to use tokens or similar protection mechanisms to authenticate the WebSocket connection when sensitive (private) data is being transferred over the WebSocket.

http/tcp long connection???

http 2.0?


### tcp long connection/keepalive
when you set up a TCP connection, you associate a set of timers. Some of these timers deal with the keepalive procedure. When the keepalive timer reaches zero, you send your peer a keepalive probe packet with no data in it and the ACK flag turned on.

### Http keep-alive

client sends a Connection: keep-alive header, and server will respond with Conneciton:keep-alive in the header
on the last request, client will use Conneciton:close in the header

http keep-alive is to reuse existing connection
tcp keep-alive is make sure the other end is still alive, but sending heartbeat packet
using a single TCP connection to send and receive multiple HTTP requests/responses, as opposed to opening a new connection for every single request/response pair.

In HTTP 1.1, all connections are considered persistent unless declared otherwise

socket api is between application layer and transport layer
