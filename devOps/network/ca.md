The server usually then provides identification in the form of a digital certificate. The certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server's public encryption key.

If you iterate the process you end up with a handful of root CA (called "trust anchors" in X.509 terminology) that are known a priori by end users (they are included in your OS / browser), and that are considered trustworthy at all meta-levels

The very first cryptographic pair we’ll create is the root pair. This consists of the root key (ca.key.pem) and root certificate (ca.cert.pem). This pair forms the identity of your CA.

The root CA is only ever used to create one or more intermediate CAs, which are trusted by the root CA to sign certificates on their behalf.  This is best practice. It allows the root key to be kept offline and unused as much as possible, as any compromise of the root key is disastrous.

The Vault instances will then use certs from an internal CA that will have CN and SAN entries for localhost, vault.service.consul, and whatever pattern I decide on for the advertise_addr.

HAproxy, for instance, can perform purely TCP-based proxying while still using SNI for routing.

A single CA certificate may be shared among multiple CAs or their resellers

a self-signed certificate is one signed with its own private key.

A Subject Alternate Name (or SAN) certificate is a digital security certificate which allows multiple hostnames to be protected by a single certificate.

For server certificates, the Common Name must be a fully qualified domain name (eg, www.example.com), whereas for client certificates it can be any unique identifier (eg, an e-mail address). Note that the Common Name cannot be the same as either your root or intermediate certificate.

most websites use 2048-bit pairs.

If the certificate is going to be used on a server, use the server_cert extension. If the certificate is going to be used for user authentication, use the usr_cert extension. Certificates are usually given a validity of one year, though a CA will typically give a few days extra for convenience.

The Issuer is the intermediate CA. The Subject refers to the certificate itself.

---------------------

TLS verification is falling because your self signed certificate has a common name which does not match what the host is. The TLS client is connecting to the server at "127.0.0.1:8200", but the CN of the certificate is some other hostname "foo.com". You can use the -tls-skip-verify to avoid this error, but for production you may want to generate a correctly signed cert!

You can also use the -ca-cert flag for most CLI commands

----------
