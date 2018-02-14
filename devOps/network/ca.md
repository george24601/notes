The server usually then provides identification in the form of a digital certificate. The certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server's public encryption key.

The client confirms the validity of the certificate before proceeding.

If you iterate the process you end up with a handful of root CA (called "trust anchors" in X.509 terminology) that are known a priori by end users (they are included in your OS / browser), and that are considered trustworthy at all meta-levels

Note that for internal services, it often makes more sense to maintain your own PKI
This is useful in a number of situations, such as issuing server certificates to secure an intranet website, or for issuing certificates to clients to allow them to authenticate to a server.

The very first cryptographic pair we’ll create is the root pair. This consists of the root key (ca.key.pem) and root certificate (ca.cert.pem). This pair forms the identity of your CA.

The root CA is only ever used to create one or more intermediate CAs, which are trusted by the root CA to sign certificates on their behalf.

This is best practice. It allows the root key to be kept offline and unused as much as possible, as any compromise of the root key is disastrous.

When an application (eg, a web browser) tries to verify a certificate signed by the intermediate CA, it must also verify the intermediate certificate against the root certificate. To complete the chain of trust, create a CA certificate chain to present to the application.
