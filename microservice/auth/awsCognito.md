An identity pool is a store of user data specific to your account. It can be configured to require an identity provider (IdP) for user authentication, after you enter details such as app IDs or keys related to that specific provider.

fter the user is validated, the provider sends an identity token to Amazon Cognito Federated Identities. In turn, Amazon Cognito Federated Identities contacts the AWS Security Token Service (AWS STS) to retrieve temporary AWS credentials based on a configured, authenticated IAM role linked to the identity pool. The role has appropriate IAM policies attached to it and uses these policies to provide access to other AWS services.

Amazon Cognito Federated Identities can be compared to a token vending machine that uses STS as a backend

The simplified user authentication flow for a given provider is:

App sends user credentials to provider, usually user name and password.
After the user is authenticated, the provider sends a valid token back to the application.
The application sends the token to the identity pool associated with it.
Amazon Cognito Federated Identities validates the token with the IdP.
If the token is valid, Amazon Cognito Federated Identities contacts STS to retrieve temporary access credentials (access key, secret key, and session token) based on the authenticated IAM role associated with the identity pool.
App contacts the specific AWS service with the temporary credentials.


-----

Amazon Cognito User Pools, on other hand is a full-fledged IdP that you can use to maintain a user directory and add sign-up and sign-in support to your mobile or web application.

It uses JSON Web Tokens (JWTs) to authenticate and validate users.

An Amazon Cognito User Pools user authenticated with a user name and password can send a JWT to an associated identity pool. In turn, the identity pool sends temporary AWS credentials back to the application to access other AWS services. There’s no difference with the authentication flow mentioned above for other IdPs.

To use a metaphor, Amazon Cognito User Pools provided you with a passport (JWT) that you can use at the airport counter to retrieve a boarding pass (access credentials) from an identity pool. With your valid boarding pass, you are then allowed to go to the airport gate and board your flight to the AWS Cloud

Even if you have the same identity pool in use by different providers (Google and Amazon Cognito User Pools), you can associate another IAM role to a group with Amazon Cognito User Pools. Because the user “jdoe” is part of that group, it inherits the IAM role association.

The ID Token (JWT) is sent directly to API Gateway and there’s no IAM role involved in the user validation. The ID in the user information card looks different compared to the previous users. As no cognito identity ID is generated in this scenario, you need another type of unique ID for the user
