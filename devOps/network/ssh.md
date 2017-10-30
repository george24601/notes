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

In the SSH public key authentication use case, it is rather typical that the users create (i.e. provision) the key pair for themselves. SSH implementations include easily usable utilities for this (for more information see ssh-keygen and ssh-copy-id).

Once an SSH server receives a public key from a user and considers the key trustworthy, the server marks the key as authorized in its authorized_keys file. Such keys are called authorized keys.

no copies of the private key should be distributed. The private keys used for user authentication are called identity keys.

When a private key is needed the user is asked to supply the passphrase so that the private key can be decrypted. The handling of passphrases can be automated with an SSH agent.

In most automated use cases (scripts, applications, etc) the private keys are not protected and careful planning and key management practises need to be excercised 

In OpenSSH, host keys are usually stored in the /etc/ssh directory, in files starting with ssh_host_<rsa/dsa/ecdsa/ed25519>_key (the location can be changed in server configuration files).

SSH clients store host keys for hosts they have ever connected to. These stored host keys are called known host keys, and the collection is often called known hosts. In OpenSSH, the collection of known host keys is stored in /etc/ssh/known_hosts

 in computing clusters sharing hosts keys may sometimes be acceptable and practical.

The login attempt is accepted if the user proves that he knows the private key and the public key is in the account's authorization list (~/.ssh/authorized_keys on the server).

Under standard security practices, every host should generate unique host keys for SSH authentication.

Manage this situation by ensuring that all node hosts have the same SSH host keys. You can either deploy all node hosts using the same base image that includes host keys, or duplicate the SSH host keys on a node host to all other node hosts.

A host key is the server’s public key. The host key is used by the client to decrypt an authentication message sent from the server when connecting. 
