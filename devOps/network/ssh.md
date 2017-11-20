log into ssh with identity file, which stores private key for RSA or DSA
```
ssh -i $CERT $HOST
```

list added certificates
```
ssh-add -l
```

add cerficicate to the agent
```
ssh-add -K ~/.ssh/id_rsa
```
go directly to host wanted
```
ssh -t $HOST "cd /directory_wanted ; bash"
```

Auth
----------

When a private key is needed the user is asked to supply the passphrase so that the private key can be decrypted. The handling of passphrases can be automated with an SSH agent.

In most automated use cases (scripts, applications, etc) the private keys are not protected and careful planning and key management practises need to be excercised 

In OpenSSH, host keys are usually stored in the /etc/ssh directory, in files starting with ssh_host_<rsa/dsa/ecdsa/ed25519>_key (the location can be changed in server configuration files).

SSH clients store host keys for hosts they have ever connected to. These stored host keys are called known host keys, and the collection is often called known hosts. In OpenSSH, the collection of known host keys is stored in /etc/ssh/known_hosts

 in computing clusters sharing hosts keys may sometimes be acceptable and practical.

The login attempt is accepted if the user proves that he knows the private key and the public key is in the account's authorization list (~/.ssh/authorized_keys on the server).

Under standard security practices, every host should generate unique host keys for SSH authentication.

Manage this situation by ensuring that all node hosts have the same SSH host keys. You can either deploy all node hosts using the same base image that includes host keys, or duplicate the SSH host keys on a node host to all other node hosts.

A host key is the server’s public key. The host key is used by the client to decrypt an authentication message sent from the server when connecting. 


Port Forwarding
---------
Local forwarding is used to forward a port from the client machine to the server machine.
Basically, the SSH client listens for connections on a configured port, and when it receives a connection, it tunnels the connection to an SSH server. The server connects to a configurated destination port, possibly on a different machine than the SSH server

```
ssh -L 80:intra.example.com:80 gw.example.com
```
This example opens a connection to the gw.example.com jump server, and forwards any connection to port 80 on the local machine to port 80 on intra.example.com.


Agent Forwarding
---------
