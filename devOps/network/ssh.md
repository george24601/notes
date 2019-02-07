# auth

Client certificates are a SSL-specific feature. a SSL server who wants to make sure that it talks to a specific, named client.(rather rare in practice)

When a private key is needed the user is asked to supply the passphrase so that the private key can be decrypted. The handling of passphrases can be automated with an SSH agent.

In most automated use cases (scripts, applications, etc) the private keys are not protected and careful planning and key management practises need to be excercised 

In OpenSSH, host keys are usually stored in the /etc/ssh directory, in files starting with ssh_host_<rsa/dsa/ecdsa/ed25519>_key (the location can be changed in server configuration files).

SSH clients store host keys for hosts they have ever connected to. These stored host keys are called known host keys, and the collection is often called known hosts. In OpenSSH, the collection of known host keys is stored in /etc/ssh/known_hosts

 in computing clusters sharing hosts keys may sometimes be acceptable and practical.

The login attempt is accepted if the user proves that he knows the private key and the public key is in the account's authorization list (~/.ssh/authorized_keys on the server).

Under standard security practices, every host should generate unique host keys for SSH authentication.

Manage this situation by ensuring that all node hosts have the same SSH host keys. You can either deploy all node hosts using the same base image that includes host keys, or duplicate the SSH host keys on a node host to all other node hosts.

A host key is the server’s public key. The host key is used by the client to decrypt an authentication message sent from the server when connecting. 


ssh-keygen	supports signing of keys to produce certificates that may be
     used for user or host authentication.  Certificates consist of a public
     key, some identity	information, zero or more principal (user or host)
     names and a set of	options	that are signed	by a Certification Authority
     (CA) key.
Clients	or servers may then trust only the CA key and verify
     its signature on a	certificate rather than	trusting many user/host	keys.

TrustedUserCAKeys: Specifies a file containing public keys of	certificate authori-
	     ties that are trusted to sign user	certificates for authentica-
	     tion. If a certificate is presented for authentication and has its signing
	     CA	key listed in this file, then it may be	used for authentica-
	     tion for any user listed in the certificate's principals list.


# Local Port Forwarding
forward data securely from another client application running on the same computer as the Secure Shell Client.

Two important items in local port forwarding are the destination server, and two port numbers. Connections from the SSH client are forwarded via the SSH server, then to a destination server. 


Using the -X flag tells SSH to forward

For trusted X11 forwarding the -Y flag can be used.

Final note is that for this to work the sshd_config on the server must have the following options

X11Forwarding yes
X11DisplayOffset 10
