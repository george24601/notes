commonly used as a way for Internet users to grant websites or applications access to their information on other websites but without giving them the passwords

OAuth essentially allows access tokens to be issued to third-party clients by an authorization server, with the approval of the resource owner. The third party then uses the access token to access the protected resources hosted by the resource server.[3]

OIDC is an authentication layer built on top of OAuth 2.0

OAuth is an authorization protocol, rather than an authentication protocol. Using OAuth on its own as an authentication method may be referred to as pseudo-authentication:
(OAuth only) The response includes an access token which the application can use to gain direct access to the identity provider's services on the user's behalf.

The crucial difference is that in the OpenID authentication use case, the response from the identity provider is an assertion of identity; while in the OAuth authorization use case, the identity provider is also an API provider, and the response from the identity provider is an access token that may grant the application ongoing access to some of the identity provider's APIs, on the user's behalf.

Because the identity provider typically (but not always) authenticates the user as part of the process of granting an OAuth access token, it's tempting to view a successful OAuth access token request as an authentication method itself. However, because OAuth was not designed with this use case in mind, making this assumption can lead to major security flaws

OpenID Connect is a simple identity layer on top of the OAuth 2.0 protocol, which allows computing clients to verify the identity of an end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user in an interoperable and REST-like manner. In technical terms, OpenID Connect specifies a RESTful HTTP API, using JSON as a data format. - just address the problem with pesudo-oauth

------
In this case, even the worst happens, you only lose the copy of referral letter. The damage is not so different than the case of OpenID.

This indeed is the basic idea behind “OpenID Connect.”

The locker is called “UserInfo Endpoint.” This allows a site to verify the user’s identity information using OAuth 2.0. This is why OpenID Connect is often called “an identity layer on OAuth.”


Thus, OpenID Connect also sends the letter containing “how and when” the authentication was performed, together with the UserInfo locker key. This letter is called “id token”. (Alternatively, you can ask ID Token endpoint to obtain it later.)

In a standard OAuth, the key is created by the each site. In OpenID Connect, the keys are created by the UserInfo Endpoint. In another word, site X,Y,Z knows how to understand the keys provided by the UserInfo endpoint. For this to happen, the sites must (1) Trust the key providing party (2) be able to verify the validity of the keys. To achieve this, OpenID Connect uses JSON Web Token (JWT) as the format for the key (Access Token) using some cryptography

-------

Scopes are what you see on the authorization screens when an app requests permissions. They’re bundles of permissions asked for by the client when requesting a token. These are coded by the application developer when writing the application.

Resource Owner: owns the data in the resource server. For example, I’m the Resource Owner of my Facebook profile.

Resource Server: The API which stores data the application wants to access
Client: the application that wants to access your data
Authorization Server: The main engine of OAuth

Access tokens are the token the client uses to access the Resource Server (API). They’re meant to be short-lived. Think of them in hours and minutes, not days and month.

The other token is the refresh token. This is much longer-lived; days, months, years. This can be used to get new tokens. To get a refresh token, applications typically require confidential clients with authentication.

The Client application sends an access token request to the token endpoint on the Authorization Server with confidential client credentials and client id. This process exchanges an Authorization Code Grant for an Access Token and (optionally) a Refresh Token. Client accesses a protected resource with Access Token.

Authorization Code Flow, aka 3 Legged,

The front channel flow is used by the client application to obtain an authorization code grant. The back channel is used by the client application to exchange the authorization code grant for an access token (and optionally a refresh token). It assumes the Resource Owner and Client Application are on separate devices

For server-to-server scenarios, you might want to use a Client Credential Flow. In this scenario, the client application is a confidential client that’s acting on its own, not on behalf of the user. It’s more of a service account type of scenario. All you need is the client’s credentials to do the whole flow. It’s a back channel only flow to obtain an access token using the client’s credentials. It supports shared secrets or assertions as client credentials signed with either symmetric or asymmetric keys.

-----
Since you want to retrieve data from a resource server using OAuth2, you have to register as a client of the authorization server.

Client registration
Application Name: the application name
Redirect URLs: URLs of the client for receiving authorization code and access token
Grant Type(s): authorization types that will be used by the client
Javascript Origin (optional): the hostname that will be allowed to request the resource server via XMLHttpRequest

Authorization server response
Client Id: unique random string
Client Secret: secret key that must be kept confidential

grants (“methods”) for a client application to acquire an access token (which represents a user’s permission for the client to access their data) which can be used to authenticate a request to an API endpoint.

-------
OpenID Connect also uses the JSON Object Signing And Encryption (JOSE) suite of specifications for carrying signed and encrypted information around in different places. In fact, an OAuth 2.0 deployment with JOSE capabilities is already a long way to defining a fully compliant OpenID Connect system, and the delta between the two is relatively small. But that delta makes a big difference, and OpenID Connect manages to avoid many of the pitfalls discussed above by adding several key components to the OAuth base:

1. The OpenID Connect ID Token is a signed JSON Web Token (JWT) that is given to the client application along side the regular OAuth access token

2. Furthermore, it is issued in addition to (and not in lieu of) an access token, allowing the access token to remain opaque to the client as it is defined in regular OAuth.

3. Finally, the token itself is signed by the identity provider's private key, adding an additional layer of protection to the claims inside of it in addition to the TLS transport protection that was used to get the token in the first place, preventing a class of impersonation attacks. By applying a few simple checks to this ID token, a client can protect itself from a large number of common attacks.

4. Since the ID Token is signed by the authorization server, it also provides a location to add detached signatures over the authorization code (c_hash) and access token (at_hash). These hashes can be validated by the client while still keeping the authorization code and access token content opaque to the client, preventing a whole class of injection attacks.

The other token is the refresh token. This is much longer-lived; days, months, years. This can be used to get new tokens. To get a refresh token, applications typically require confidential clients with authentication.

Tokens are retrieved from endpoints on the authorization server. The two main endpoints are the authorize endpoint and the token endpoint. They’re separated for different use cases. The authorize endpoint is where you go to get consent and authorization from the user. This returns an authorization grant that says the user has consented to it. Then the authorization is passed to the token endpoint. The token endpoint processes the grant and says “great, here’s your refresh token and your access token”.oo

The downside is this causes a lot of developer friction. One of the biggest pain points of OAuth for developers is you having to manage the refresh tokens. You push state management onto each client developer. You get the benefits of key rotation, but you’ve just created a lot of pain for developers. That’s why developers love API keys. They can just copy/paste them, slap them in a text file, and be done with them. API keys are very convenient for the developer, but very bad for security.

The tokens are meant to be consumed by the client application so it can access resources on your behalf. We call that the back channel. The back channel is a direct HTTP call directly from the client application to the resource server to exchange the authorization grant for tokens. These channels are used for different flows depending on what device capabilities you have.

One major benefit of building authentication on top of authorization in this way is that it allows for management of end-user consent, which is very important in cross-domain identity federation at internet scale. Another important benefit is that the user can delegate access to other protected APIs along side their identity at the same time, making it much simpler for both application developers and end users to manage. With one call, an application can find out if a user is logged in, what the app should call the user, download photos for printing, and post updates to their message stream.
