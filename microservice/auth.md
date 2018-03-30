I found using OAuth delegated authorization along with JSON Web Tokens (JWT) to be the most efficient and scalable solution for authentication and authorization for microservices.

To illustrate further, a user starts by sending his credentials to the API gateway which will forward the credentials to the Authorization Server (AS) or the OAuth Server. The AS will generate a JASON Web Token (JWT) and will return it back to the user.

The API Gateway will forward the request with the JWT to the microservice that owns this resource. The microservice will then decide to either grant the user the resource (if the user has the required permissions) or not. Based on the implementation, the microservice can make this decision by itself (if it knows the permissions of this user over this resource) or simply forward the request to one of the Authorization Servers within the environment to determine the user’s permissions.

If this was a critical feature, then the API Gateway can play a pivotal role by sending a reference of the JWT to the user instead of the JWT value itself. Each time the user requests a resource from the API Gateway, the API Gateway will convert the reference to the JWT value and forward it as normal. If revoking the permissions is needed, then only a single request to the API Gateway will be provided, then the API Gateway can kill the session for that user.

----------

the user send his credentials to the OAuth server
The server Checks the user's information (from LDAP server for example), then gives him an access token
the user send his request with the access token to the API Gateway
the API Gateway extracts out the access_token from the request, then he will talks to the Token Exchange endpoint to validate it and then issues a JWT
this JWT That contains all the necessarily information about the user will be sent to the micro-service.
the micro-service also should verify the validity of the token by talking to the token exchange endpoint.
when the token is checked, the micro-service can start its job.

separate authen and authorization filter

Each microservice should not have to do its own authentication, but it does need to do its own authorization

with JWT, authorization can be done at individual services

Apereo CAS
spring cloud security
keycloak
OpenID-Connect-Java-Spring-Server

run an openid-connect (an oAuth extension) service that handles logins and token generation separate from the rest of the APIs, which lines up pretty well with the whole microservice way of doing things

authentication, billing, and identity information should all be in separate services with separate databases. Keep track of object-level permissions in the API that those objects live in, and manage permissions with special scopes. API clients should only get the immutable userid from your microservice API, and should cross-reference an identity API to get more context.

--------

For the sake of saving the need to access a central user data service from every backend service, the Bouncer adds a user data header to the HTTP request which is sent to the backend service. This helps reduce the complexity and external dependencies of the backend service.

We use Consul to communicate this data between the backend services and the Bouncer and use Consul’s blocking queries in order to emulate a real-time input stream.

If a request is made to a secured route, i.e. a route which maps to a service with the flag secured set, it will request a JWT from an authentication service. JWT stands for JSON Web Token which is an open industry standard for representing security claims in a web context. We could plugin any REST service here that responds to GET /auth/token with a response of the format

which retrieves a user claim based on a reference token in a domain cookie and generates a JWT for this claim. If a valid JWT is returned the call is forwarded to the corresponding service and the JWT is passed in the request header as an Oauth bearer token for further authorization to be done by the backing service.

JWT is solely communicated internally between services and never leaves the Kubernetes cluster. Only the reference token, which is just a random string, ends up in the client’s browser session. This way we don’t have to worry about clients tampering tokens.

we inject our shared authentication secret as an environment variable so we can use it to encode JWT’s. Then we also need a Kubernetes service which is pretty straight forward

the importance of considering the importance of logout when choosing a solution.

Borsos notes that a single sign-on (SSO) solution may look as a good idea, but it means that every public facing service must talk to the authentication service giving quite chatty traffic. It’s also fairly complex to implement. On the other hand the security is as good as the chosen SSO, and the user login state is opaque, preventing an attacker from inferring any useful information from the state

With a distributed session solution, information about the user authentication is stored in a shared data store, often just a simple distributed hash map keyed by the user session. When a user accesses a microservice, user data can then be fetched from the data store. Another advantage to this solution is that the user login state is opaque. When using a distributed database, it’s also a highly available and scalable solution. Downsides include the fact that the data store should be protected and therefore only accessible over a secure connection, and that the implementation of the solution often has a rather high complexity.

Keycloak, at least for a proof of concept - it's an open source offering from RedHat. It utilizes Open ID Connect (OIDC), which is an extension of OAuth 2 (adds an ID layer).

OAuth 2 client credentials grant is designed for communications between services. Authentication for client credentials grant typically involves passing a shared secret,

--------

1. client login to acquire access token

2. client send access token to the API gateway

3. gateway use auth server to validate token and convert to JWT

4. gateway sends jwt token along with requests to backend microservices

5. every microservice has JWT client to decrypt user context inside the jwt

----

OAuth 2.0 - Is an access delegation protocol. The client authenticates with an authorization server and gets an opaque token, which is known as the 'Access token'. The access token has zero information about the user/client. It only has a reference to the user information that can only be retrieved by the authorization server. Hence, this is known as a 'by-reference token' and it is safe to use this token even in the public network/internet.

OpenID Connect behaves similar to OAuth, but in addition to the Access token, the authorization server issues an ID token that contains information about the user. This is often implemented by a JWT (JSON Web Token) and that is signed by the authorization server. This ensures trust between the authorization server and the client. JWT is therefore known as a ‘by-value token’ as it contains information of the user and obviously is not safe to use outside the internal network.


The approach I would like to suggest is to build a private certificate authority (CA) and also there can be intermediate certificate authorities by different microservices teams, if a need arises. Now, rather than trusting each and every individual certificate, the downstream microservices will only trust either the root certificate authority or an intermediary

Caching the JWT at the microservices level against the data extracted out of it would reduce the impact of repetitive token validation. The cache expiration time must match the JWT expiration time. Once again the impact of caching would be quite low if the JWT expiration time is quite low.

