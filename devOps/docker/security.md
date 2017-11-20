Typically, you'll see docs and blogs demonstrating containers being started with a slew of environment variables containing sensitive information, and existence of that exposure was the problem I decided to solve

All of sensitive environment variables (including what could have included a VAULT_TOKEN) are gone. Now it is just one token-service API key. Every container start sees the creation of a new one-time (or short-lived) vault token for read-only access to a limited path. Should anyone docker inspect the container, there would be no passwords to view, no VAULT_TOKENs to misuse, no TOKEN_API_KEY that're authorized to use. VAULT_TOKENs can be rotated regularly without interruption, or easily revoked

wrote a docker launcher that uses envconsul to grab secrets from vault and inject them securely at runtime.

Passwords, API keys, secure Tokens, and confidential data fall into the category of secrets.
That’s data which shouldn’t lie around. It mustn’t be available in plaintext in easy to guess locations. In fact, it must not be stored in plaintext in any location.

Load the environment at run time from vault.

We will need to pass in the environment (ie: production or staging), the vault token, & maybe the vault server url

Spring Cloud Vault

vault from dockito, that runs in its own container to serve the key over the HTTP.During the build, it’s invoked from the Dockerfile, using a special RUN directive, where you just pass it the command that requires the secret. It will fetch the key from the server and executes the command.

In that, it fetches the key over the network from the server container, writes it to disk, executes the desired command, and then removes the key. Since all this occurs within the scope of a single RUN directive, the key data is never written into the resulting filesystem layer.

docker-ssh-exec is a bit more advanced that vault from dockito. In that, it fetches the key over the network from the server container, writes it to disk, executes the desired command, and then removes the key. Since all this occurs within the scope of a single RUN directive, the key data is never written into the resulting filesystem layer.
