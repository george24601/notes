OpenID Connect is built directly on OAuth 2.0 and in most cases is deployed right along with (or on top of) an OAuth infrastructure. OpenID Connect also uses the JSON Object Signing And Encryption (JOSE) suite of specifications for carrying signed and encrypted information around in different places. In fact, an OAuth 2.0 deployment with JOSE capabilities is already a long way to defining a fully compliant OpenID Connect system, and the delta between the two is relatively small. But that delta makes a big difference, and OpenID Connect manages to avoid many of the pitfalls discussed above by adding several key components to the OAuth base:

The OpenID Connect ID Token is a signed JSON Web Token (JWT) that is given to the client application along side the regular OAuth access token

Furthermore, it is issued in addition to (and not in lieu of) an access token, allowing the access token to remain opaque to the client as it is defined in regular OAuth.

Finally, the token itself is signed by the identity provider's private key, adding an additional layer of protection to the claims inside of it in addition to the TLS transport protection that was used to get the token in the first place, preventing a class of impersonation attacks. By applying a few simple checks to this ID token, a client can protect itself from a large number of common attacks.

Since the ID Token is signed by the authorization server, it also provides a location to add detached signatures over the authorization code (c_hash) and access token (at_hash). These hashes can be validated by the client while still keeping the authorization code and access token content opaque to the client, preventing a whole class of injection attacks.

Clients can be public and confidential. There is a significant distinction between the two in OAuth nomenclature. Confidential clients can be trusted to store a secret. They’re not running on a desktop or distributed through an app store. People can’t reverse engineer them and get the secret key. They’re running in a protected area where end users can’t access them.

The other token is the refresh token. This is much longer-lived; days, months, years. This can be used to get new tokens. To get a refresh token, applications typically require confidential clients with authentication.

Tokens are retrieved from endpoints on the authorization server. The two main endpoints are the authorize endpoint and the token endpoint. They’re separated for different use cases. The authorize endpoint is where you go to get consent and authorization from the user. This returns an authorization grant that says the user has consented to it. Then the authorization is passed to the token endpoint. The token endpoint processes the grant and says “great, here’s your refresh token and your access token”.oo

The downside is this causes a lot of developer friction. One of the biggest pain points of OAuth for developers is you having to manage the refresh tokens. You push state management onto each client developer. You get the benefits of key rotation, but you’ve just created a lot of pain for developers. That’s why developers love API keys. They can just copy/paste them, slap them in a text file, and be done with them. API keys are very convenient for the developer, but very bad for security.

The tokens are meant to be consumed by the client application so it can access resources on your behalf. We call that the back channel. The back channel is a direct HTTP call directly from the client application to the resource server to exchange the authorization grant for tokens. These channels are used for different flows depending on what device capabilities you have.



As it turns out, though, there are a handful of things that can be used along with OAuth to create an authentication and identity protocol on top of this delegation and authorization protocol. In nearly all of these cases, the core functionality of OAuth remains intact, and what's happening is that the user is delegating access to their identity to the application they're trying to log in to. The client application then becomes a consumer of the identity API, thereby finding out who authorized the client in the first place. One major benefit of building authentication on top of authorization in this way is that it allows for management of end-user consent, which is very important in cross-domain identity federation at internet scale. Another important benefit is that the user can delegate access to other protected APIs along side their identity at the same time, making it much simpler for both application developers and end users to manage. With one call, an application can find out if a user is logged in, what the app should call the user, download photos for printing, and post updates to their message stream.


