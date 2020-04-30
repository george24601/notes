
what metrics we have on meterregistry on db connections?

tidb itself will not close the connection actively, but the LB/proxy in front of the tidb often does close it, that is why keep alive or connection probe is still needed

com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

In the tidb repo:
server:
dir for mysql protocol and session management
every conneciton is mapped to a session

tidb-server:
service's main method

x-server:
X-protocol related

Protocol layer: inside the server package
* Listener
* Connection Context
* Protocol decode/encode

create connection:
```go
conn, err := s.listener.Accept()
go s.onConn(conn)
```

clientConn.dispatch for handling requests from a single session

clientConn.Run()

```go
data, err := cc.readPacket()
# dispatch actually handles request
if err = cc.dispatch(data); err != nil {
}
```

default value:
```toml
# The limit of concurrent executed sessions.
token-limit = 1000

# The maximum permitted number of simultaneous client connections.
max-server-connections = 4096

```






