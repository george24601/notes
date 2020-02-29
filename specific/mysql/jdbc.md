It is a limitation on how long a statement should run. It sets the timeout value for the statement, which is a JDBC API. The JDBC driver processes the statement timeout based on this value. Statement timeout is configured via java.sql.Statement.setQueryTimeout(int timeout), which is a JDBC API. In recent developing environments, the developers rarely configure the statement timeout value directly through Java source codes, but often configure it by using the framework.

Statement timeout works differently per DBMS and driver

Creates a statement by calling Connection.createStatement().
Calls Statement.executeQuery().
The statement transmits the Query to MySqlServer by using the internal connection.
The statement creates a new timeout-execution thread for timeout process.
For version 5.1.x, it changes to assign 1 thread for each connection.
Registers the timeout execution to the thread.
Timeout occurs.
The timeout-execution thread creates a connection that has the same configurations as the statement.
Transmits the cancel Query (KILL QUERY "connectionId“) by using the connection.

Socket timeout value for JDBC driver is necessary when the DBMS is terminated abruptly or an network error has occured (equipment malfunction, etc.). Because of the structure of TCP/IP, there are no means for the socket to detect network errors. Therefore, the application cannot detect any disconnection with the DBMS. If the socket timeout is not configured, then the application may wait for the results from the DBMS indefinitely. (This connection is also called a "dead connection.") To prevent dead connections, a timeout must be configured for the socket. Socket timeout can be configured via JDBC driver. By setting up the socket timeout, you can prevent the infinite waiting situation when there is a network error and shorten the failure time.

jdbc:mysql://xxx.xx.xxx.xxx:3306/database?connectTimeout=60000&socketTimeout=60000

The default value for connectTimeout and socketTimeout is "0," which means that the timeout does not occur.

Q3. If JDBC SocketTimeout is configured, wouldn't the connections that stayed in idle status for a long time in DBCP be closed?

No. The socket option is applied when the actual data is being written or read, so it does not affect the connections in idle status in DBCP. The socket option can have certain effect when new connections that lack in inside of DBCP are created, old idle connections are removed, or the validation is checked, but this does not cause any significant issues unless the network has an error.
