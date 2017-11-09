Certain data like binary blobs and configuration files are best left out of source control for performance and usability reasons. But more importantly, sensitive data like passwords, secrets, and private keys should never be checked into a repository unprotected for security reasons.

An important point that is often overlooked is that the keys used to decrypt the data are often stored alongside the encrypted content.

In general, protecting secrets within a repository over a long period of time can be difficult. Simple operations like rolling back code changes can accidentally reintroduce access that was previously removed. If a private key is exposed, historical values may be recovered and decrypted from the repository history. Although the VCS history provides a log of encryption changes, there is no method of auditing secret access to help determine unusual access.

anaged by Chef. Encrypted data bags are used to protect sensitive values from appearing in revision history or to other machines using shared secrets. Chef-vault allows secrets to be encrypted using the target machine's public key instead, offering further security that isolates decryption capabilities to the intended recipients.

It's easier to migrate secrets to encryption using tooling native to your environment and it's simpler to incorporate runtime decryption of secrets without additional steps. If you are already using a configuration management system, using their included secret management mechanisms will probably be the easiest first step towards protecting your sensitive data.

. Fundamentally, any system that has both the encrypted values and the decryption key will be vulnerable to this type of compromise

while the configuration management system is able to ensure secrets are only accessible to the correct machines, defining fine grained access controls to restrict team members is often more difficult.

One of the most important improvements that centralized secret management provides is auditability. Each of the systems mentioned above maintain extensive records of when secrets are added, requested, accessed, or modified.


