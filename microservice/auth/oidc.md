In the domain model associated with OIDC, an identity provider is a special type of OAuth 2.0 authorization server.

-----
Common pitfalls for authentication using OAuth
1. Access tokens as proof of authentication. 
 This problem stems from the fact that the client is not the intended audience of the OAuth access token. Instead, it is the authorized presenter of that token, and the audience is in fact the protected resource. The protected resource is not generally going to be in a position to tell if the user is still present by the token alone, since by the very nature and design of the OAuth protocol the user will not be available on the connection between the client and protected resource. To counter this, there needs to be an artifact that is directed at the client itself. This could be done by dual-purposing the access token, defining a format that the client could parse and understand. However, since general OAuth does not define a specific format or structure for the access token itself, protocols like OpenID Connect's ID Token and Facebook Connect's Signed Response provide a secondary token along side the access token that communicates the authentication information directly to the client. This allows the primary access token to remain opaque to the client, just like in regular OAuth.

2. Access of a protected API as proof of authentication

Since the access token can be traded for a set of user attributes, it is tempting to think that posession of a valid access token is enough to prove that a user is authenticated. This assumption turns out to be true in some cases, where the token was freshly minted in the context of a user being authenticated at the authorization server. However, that's not the only way to get an access token in OAuth. Refresh tokens and assertions can be used to get access tokens without the user being present, and in some cases access grants can occur without the user having to authenticate at all.

Furthermore, the access token will generally be usable long after the user is no longer present. Remember, since OAuth is a delegation protocol, this is fundamental to its design. This means that if a client wants to make sure that an authentication is still valid, it's not sufficient to simply trade the token for the user's attributes again because the OAuth protected resource, the identity API, often has no way of telling if the user is there or not.

3. Injection of access tokens

4. Lack of audience restriction

5. Injection of invalid user information

6. Different protocols for every potential identity provider

----------

The Authorization Code Flow goes through the following steps.

Client prepares an Authentication Request containing the desired request parameters.
Client sends the request to the Authorization Server.
Authorization Server Authenticates the End-User.
Authorization Server obtains End-User Consent/Authorization.
Authorization Server sends the End-User back to the Client with an Authorization Code.
Client requests a response using the Authorization Code at the Token Endpoint.
Client receives a response that contains an ID Token and Access Token in the response body.
Client validates the ID token and retrieves the End-User's Subject Identifier.


-------
In fact, much of the point of OAuth is about giving this delegated access for use in situations where the user is not present on the connection between the client and the resource being accessed. This is great for client authorization, but it's really bad for authentication where the whole point is figuring out if the user is there or not (and who they are).


The crucial difference is that in the OpenID authentication use case, the response from the identity provider is an assertion of identity; while in the OAuth authorization use case, the identity provider is also an API provider, and the response from the identity provider is an access token that may grant the application ongoing access to some of the identity provider's APIs, on the user's behalf.

------
The locker is called “UserInfo Endpoint.” This allows a site to verify the user’s identity information using OAuth 2.0. This is why OpenID Connect is often called “an identity layer on OAuth.”

Thus, OpenID Connect also sends the letter containing “how and when” the authentication was performed, together with the UserInfo locker key. This letter is called “id token”. (Alternatively, you can ask ID Token endpoint to obtain it later.)

In a standard OAuth, the key is created by the each site. In OpenID Connect, the keys are created by the UserInfo Endpoint. In another word, site X,Y,Z knows how to understand the keys provided by the UserInfo endpoint. For this to happen, the sites must (1) Trust the key providing party (2) be able to verify the validity of the keys. To achieve this, OpenID Connect uses JSON Web Token (JWT) as the format for the key (Access Token) using some cryptography

-------

Scopes are what you see on the authorization screens when an app requests permissions. They’re bundles of permissions asked for by the client when requesting a token. These are coded by the application developer when writing the application.

The front channel flow is used by the client application to obtain an authorization code grant. The back channel is used by the client application to exchange the authorization code grant for an access token (and optionally a refresh token). It assumes the Resource Owner and Client Application are on separate devices

----
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
Tokens are retrieved from endpoints on the authorization server. The two main endpoints are the authorize endpoint and the token endpoint. They’re separated for different use cases. The authorize endpoint is where you go to get consent and authorization from the user. This returns an authorization grant that says the user has consented to it. Then the authorization is passed to the token endpoint. The token endpoint processes the grant and says “great, here’s your refresh token and your access token”.oo

The downside is this causes a lot of developer friction. One of the biggest pain points of OAuth for developers is you having to manage the refresh tokens. You push state management onto each client developer. You get the benefits of key rotation, but you’ve just created a lot of pain for developers. That’s why developers love API keys. They can just copy/paste them, slap them in a text file, and be done with them. API keys are very convenient for the developer, but very bad for security.

The tokens are meant to be consumed by the client application so it can access resources on your behalf. We call that the back channel. The back channel is a direct HTTP call directly from the client application to the resource server to exchange the authorization grant for tokens. These channels are used for different flows depending on what device capabilities you have.

One major benefit of building authentication on top of authorization in this way is that it allows for management of end-user consent, which is very important in cross-domain identity federation at internet scale. Another important benefit is that the user can delegate access to other protected APIs along side their identity at the same time, making it much simpler for both application developers and end users to manage. With one call, an application can find out if a user is logged in, what the app should call the user, download photos for printing, and post updates to their message stream.
