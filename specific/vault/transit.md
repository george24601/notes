similar capbilities as KMS - encryption keys to be stored

but vault also supports other types of secrete data, e.g., API keys, database credentials, PKI keys

The primary use case for transit is to encrypt data from applications while still storing that encrypted data in some primary data store. This relieves the burden of proper encryption/decryption from application developers and pushes the burden onto the operators of Vault.

Usually each application has its own encryption key ring.

All plaintext data must be base64-encoded

Note that Vault does not store any of this data. The caller is responsible for storing the encrypted ciphertext. When the caller wants the plaintext, it must provide the ciphertext back to Vault to decrypt the value.
