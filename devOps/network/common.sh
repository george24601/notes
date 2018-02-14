#check if port is open and accessible, -z means sending no data, just scanning the daemon
nc -z $HOST $PORT

host $FIND_IP_OF_HOST

#(TLS) Tells curl to use the specified certificate file to verify the peer. The file may contain multiple CA certificates. The certificate(s) must be in PEM format. Normally curl is built to use a default file for this, so this option is typically used to alter that default file.
curl --cacert <file>
