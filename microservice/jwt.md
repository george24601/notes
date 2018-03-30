https://jwt.io

App token, user token, app asserted token


Here the microservices either have to rely on the user being authorized or ask the authorization service with every call whether the user is actually allowed to access the service.

The latter results in a highly chained microservices construct, as every microservice request triggers a request to the authorization service. If that service fails or there are lags in the network, this bad design means the effects are apparent everywhere.

JWTs consist of three parts: header, payload and signature. The JWT header contains the token type and the hashing algorithm used. It is Base64-encoded, as is the payload, which contains the authorization information for the user and typically the user's rights and name. It is moreover useful to include an expiry period in the payload.

The signature is required to verify the authenticity of the token. It consists of the encoded header, the payload and the secret key, which is the authorization service's signature making it possible to check the token's authenticity.

Pure oAuth2: tokens must be verified against resource server

oAuth2 with JWTs: tokens can be verified locally with a public key

other microservices then only have to contain the code for checking the signature and know the public key. As the token is sent with the authorization header as a bearer token, it can be evaluated by the microservices. Thanks to the signature there are no restrictions regarding URLs; this means that cross-site authorization is also possible, which in turn supports single sign-on (SSO) and is of great interest to users.

A signed JWT is known as a JWS (JSON Web Signature) and an encrypted JWT is known as a JWE (JSON Web Encryption). In fact a JWT does not exist itself — either it has to be a JWS or a JWE

In authentication, when the user successfully logs in using their credentials, a JSON Web Token will be returned and must be saved locally (typically in local or session storage, but cookies can also be used), instead of the traditional approach of creating a session in the server and returning a cookie.

Whenever the user wants to access a protected route or resource, the user agent should send the JWT, typically in the Authorization header using the Bearer schema. The content of the header might look like the following:

Authorization: Bearer eyJhbGci...<snip>...yu5CSpyHI
This is a stateless authentication mechanism as the user state is never saved in server memory. The server's protected routes will check for a valid JWT in the Authorization header, and if it is present, the user will be allowed to access protected resources. As JWTs are self-contained, all the necessary information is there, reducing the need to query the database multiple times.

TLS Mutual Authentication
Both in TLS mutual authentication and JWT-based approach, each microservice needs to have it’s own certificates. The difference between the two approaches is, in JWT-based authentication, the JWS can carry both the end user identity as well as the upstream service identity. With TLS mutual authentication, the end user identity has to be passed at the application level.


