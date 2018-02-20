We recommend running the install-vault script as part of a Packer template to create a Vault Amazon Machine Image (AMI) (see the vault-consul-ami example for sample code). You can then deploy the AMI across an Auto Scaling Group using the vault-cluster module (see the vault-cluster-public and vault-cluster-private examples for fully-working sample code).

Use the private-tls-cert module to generate a CA cert and public and private keys for a TLS cert:

Set the dns_names parameter to vault.service.consul. If you're using the vault-cluster-public example and want a public domain name (e.g. vault.example.com), add that domain name here too.
Set the ip_addresses to 127.0.0.1.
For production usage, you should take care to protect the private key by encrypting it (see Using TLS certs for more info).


Update the variables section of the vault-consul.json Packer template to specify the AWS region, Vault version, Consul version, and the paths to the TLS cert files you just generated.

Run packer build vault-consul.json.

Your client (e.g. a web browser) can decide to trust this newly created Certificate Authority by including its CA Cert (the CA's public key) when making an outbound request to a service that uses the TLS certificate.

