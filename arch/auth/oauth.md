

OAuth 2.0 is the industry-standard protocol for authorizing or giving permissions to apps. This differs from authentication, which is the process of verifying the identity of the user or the app

### Shopify OAuth flow

* The merchant makes a request to install the app.
* The app redirects to Shopify to load the OAuth grant screen and requests the merchant to authorize the required scopes.
* The merchant authorizes the app by consenting to the requested scopes.
* The app receives an authorization grant. This is a temporary credential representing the authorization.
* The app requests an access token by authenticating with Shopify and presenting the authorization grant.
* Shopify authenticates the app, validates the authorization grant, and then issues and returns an access token. The app can now request data from Shopify.
* The app uses the access token to make requests to the Shopify API.
* Shopify validates the access token and returns the requested data.

### Shopify session token

* After the frontend code has loaded, your app calls a Shopify App Bridge action to get the session token. Your app includes the session token in an authorization header when it makes any HTTPS requests to its backend.

#### Sequence of actions 

* Shopify loads, ask the Shopify app to load
* Shopify app BE loads FE 
* FE calls app bridge to request a session token
* FE calls app BE with the session token
* app BE authenticates and returns data to FE if successful

The lifetime of a session token is one minute. Session tokens must be fetched using Shopify App Bridge on each request to make sure that stale tokens aren't used.

Unlike API access tokens, session tokens can't be used to make authenticated requests to Shopify APIs. An API access token is what you use to send requests from your app's backend to Shopify so that you can fetch specific data from the merchant's shop.

For example, to make authenticated requests to the Admin API, your app must store the access token it receives during the OAuth flow. To contrast, session tokens are used by your app's backend to verify the embedded request coming from your app's frontend.

Session tokens use the JSON Web Token (JWT) format and contain information about the merchant that's currently using your embedded app.



