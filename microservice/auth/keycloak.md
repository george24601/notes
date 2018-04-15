Users authenticate with Keycloak rather than individual applications

This also applied to logout. Keycloak provides single-sign out, which means users only have to logout once to be logged-out of all applications that use Keycloak.

Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the social network you want to add. No code or changes to your application is required.

Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is just a matter of configuring the Identity Provider through the admin console.

You can also implement your own provider if you have users in other stores, such as a relational database.

In a standard OAuth, the key is created by the each site. In OpenID Connect, the keys are created by the UserInfo Endpoint. In another word, site X,Y,Z knows how to understand the keys provided by the UserInfo endpoint. For this to happen, the sites must (1) Trust the key providing party (2) be able to verify the validity of the keys. To achieve this, OpenID Connect uses JSON Web Token (JWT) as the format for the key (Access Token) using some cryptography

Service Provider Interfaces 
