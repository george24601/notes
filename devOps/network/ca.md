The server usually then provides identification in the form of a digital certificate. The certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server's public encryption key.

The client confirms the validity of the certificate before proceeding.

If you iterate the process you end up with a handful of root CA (called "trust anchors" in X.509 terminology) that are known a priori by end users (they are included in your OS / browser), and that are considered trustworthy at all meta-levels

Note that for internal services, it often makes more sense to maintain your own PKI
This is useful in a number of situations, such as issuing server certificates to secure an intranet website, or for issuing certificates to clients to allow them to authenticate to a server.

The very first cryptographic pair we’ll create is the root pair. This consists of the root key (ca.key.pem) and root certificate (ca.cert.pem). This pair forms the identity of your CA.

The root CA is only ever used to create one or more intermediate CAs, which are trusted by the root CA to sign certificates on their behalf.

This is best practice. It allows the root key to be kept offline and unused as much as possible, as any compromise of the root key is disastrous.

A CA will not grant a certificate that contains a non-public hostname.

A CA acts as a trusted third party—trusted both by the subject (owner) of the certificate and by the party relying upon the certificate. The format of these certificates is specified by the X.509 standard.

The Vault instances will then use certs from an internal CA that will have CN and SAN entries for localhost, vault.service.consul, and whatever pattern I decide on for the advertise_addr.

HAproxy, for instance, can perform purely TCP-based proxying while still using SNI for routing.

A single CA certificate may be shared among multiple CAs or their resellers

a self-signed certificate is one signed with its own private key.

A Subject Alternate Name (or SAN) certificate is a digital security certificate which allows multiple hostnames to be protected by a single certificate.

---------------------

TLS verification is falling because your self signed certificate has a common name which does not match what the host is. The TLS client is connecting to the server at "127.0.0.1:8200", but the CN of the certificate is some other hostname "foo.com". You can use the -tls-skip-verify to avoid this error, but for production you may want to generate a correctly signed cert!

If you do not want to add the self-signed cert to your local system, you can skip TLS verification. However, this reduces security. I would recommend installing the cert onto your system instead.

You can also use the -ca-cert flag for most CLI commands
