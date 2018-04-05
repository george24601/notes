Very important to consider the logout scenario! If revoking the permissions is needed, then only a single request to the API Gateway will be provided, then the API Gateway can kill the session for that user.

separate authen and authorization filter

OAuth 2 client credentials grant is designed for communications between services. Authentication for client credentials grant typically involves passing a shared secret,
bearer token is normally some kind of secret value created by the authentication server. It isn't random; it is created based upon the user giving you access and the client your application getting access.

Refresh tokens are stored in DB and will have long expiration (example: 1 month).

A user can get a new access token (when it expires, every 30 minutes for example) using a refresh token, that the user had received in the first request for token. When an access token expires, the client must send a refresh token. If this refresh token exists in DB, the server will return to the client a new access token and another refresh token (and will replace the old refresh token by the new one).

The  Authorization: <type> <credentials> pattern was introduced by the W3C in HTTP 1.0,

After the access_token expires, an active refresh_token can be used to get a new access_token / refresh_token pair as shown in the following example. This cycle can continue for up to 90 days after which the user must log in again. If the refresh_token expires, the tokens cannot be renewed and the user must log in again.

POST /login/refreshToken HTTP/1.1 - note that the refresh token returned will be different!

The information is signed with either a secret (using an HMAC) or a public/private key-pair using RSA

Authorization header is not a simple header, hence a pre-flight request would be required for all the requests to a particular URLs.

But this happens if you are sending Content-Type: application/json for instance. So this is already happening for most applications.

One small caveat, the OPTIONS request won't have the Authorization header itself, so your web framework should support treating OPTIONS and the subsequent requests differently


