Separating user and authorization, and having authorization managed in each microservice seems to be a good architecture :

each microservice could evolve at its own pace
you don't create an unnecessary dependency between the user identity service and the other microservices (if you would maintain a global list of roles/authorization you would couple the services)

you could add new microservices without having to worry about the other ones.

Each microservice should not have to do its own authentication, but it does need to do its own authorization

we like to run an openid-connect (an oAuth extension) service that handles logins and token generation separate from the rest of the API

Each API should keep track of its own object-level permissions, and it can do so without anything more than a pre-validated userid or groupid. Simply record an object or row that has the id of the object, the id of the user or group, and a set of flags for which permissions they have on that object. That way, when a user tries to do an action on an object, we can join to the appropriate permissions object if it exists, and determine what the user can and can't do to that object. The point is, object-level-permissions exists in the microservice database store without extra user context.

The only users who can change permissions or have any access to REST routes that involve permissions, should be users with a special administrator or group-administrator scope in their webtoken. This way, you can bootstrap and manage the permissions for other users.

Keep track of object-level permissions in the API that those objects live in, and manage permissions with special scopes. API clients should only get the immutable userid from your microservice API, and should cross-reference an identity API to get more context.

He added the requirement that Microservices should be stateless, which means no sessions. You should pass the auth details each time instead of using a cookie/session.

. Refactoring inside a single code base is easy these days, while refactoring across service boundaries is hard. Scott table a few approaches to managing architecture change:

Don’t do it – live with the chaos of the distributed logic rather than the chaos of not knowing who’s responsible for maintaining the shared service.
One big version change – version all your services, test them together and release them together. However, Scott said *You should not have to version your services.* (Conflicting with Cameron Barrie’s advice in the Mobile at Warp Speed session: “You need the flexibility to change your APIs, and you can’t do that without versioning.”)
Build a temporary team (due to concern about conway’s law) to build the third service. Make sure you make the long-term ownership of the service clear after the temp team has disbanded. “Long-term ownership can’t be ambiguous.”

ASP.NET Core Identity stores information about different roles used by the application and keeps track of which users are assigned to which roles.

JWT with roles, each individual service will auth on the roles, e.g., Authorize header/annotation

apparently, asp.net core supports both role-based and policy-based authorization

We came up with an architecture in which each service is responsible for handling authentication and authorization itself, but the management of roles is handled by a single user service. We use Keycloak (http://keycloak.jboss.org/) as the identity provider that supports OAuth/openid-connect and provides JWT based access tokens. All services and users are managed in keycloak, authentication is done using OAuth standard flows. Keycloak then adds the roles of the authenticated user to the JWT token, which is sent around with all backend requests. Each microservices verifies the token and extracts the identity of the user and his roles. When the signature is valid, we can check whether the token is expired or not. If it is not expired we know that the user is still "logged in". We then use the provided roles to figure out the permissions of the user and accept or deny the request accordingly. So while the concrete "log in" (i.e. verification of credentials) is done by Keycloak, each microservices decides on its own (based on the token) whether the user is still authenticated and authorized for the requested action.

authorization is part of domain and should be modelled accordingly within a bounded context, which corresponds to a microservice in our architecture.


permissions in authorization service has many to many relationship with roles in user service. A permission has a many to many relationship with activities(endpoint). A user has many roles and hence many permissions. When a user makes a request to the api gateway, the request passes through the authorization middleware which extracts the jwt(from cookie or header), verifies that it’s valid and retrieves the permissions claim from the jwt. Afterwards, the Authorize endpoint of the authorization service is called with the permissions as well as the url and http verb of the called endpoint. The authorize endpoint essentially returns true if any of the user’s permission has access to the endpoint.


Another factor that has pushed the authorization bulwark back onto our layer of gateways and applications is that many of our authorizations are application-data-based. That is, making that authorization decision requires information that the application has and would have to share with the authorization service (whether to generate an auth token like a JWT or to delegate to that service).

authorization is part of the domain and should therefore be handled within a single microservice. If you push authorization into a gateway, it means the gateway has to know about every microservice behind it (at least in the worst case). Authentication is another topic. That's something that can easily be done using a dedicated service.



That makes sense. Having a central authorization has it’s own complexities. Managing it at the microservice level is definitely a simpler and more straight forward approach. For us, the reason why we chose a central authorization is because we want to be able to create new permissions and map them to endpoints directly via a UI. This is especially important since we have different apps that might be accessing the same endpoints and different permissions will need access to those endpoints.

We are currently planning on removing permissions from our jwt claims though because the number of permission some users have is becoming quite large since they use these permissions to access over 5 apps.

My only worry with having each service implement their own authorization is duplication of authorization logic across services.

---------

Centralize what you can

From experience, common roles can be enforced if they exist globally
● Org admin
● Billing administrator

Service-level granularities are best left to the layer that understands them

You might not know which specific objects they have access to in a database,
though (maybe you do)
● You don’t know the nitty gritty business rules of a given service (unless you’ve
already extracted them to a Lambda function)

● It’s very easy to overcomplicate your security architecture and design

Central Access Control Service is responsible for the creation, update, and deletion of permissions for all objects in the system. Access Control Service database is the primary store of objects' permissions.

Permissions stored in microservices databases are synchronized with Access Control Service database using event-carried state transfer. Every time, permissions are changed an event is sent to the message broker. Microservices can subscribe to these events to synchronize permissions.

-----

I'd imagine having some kind of "User Service" that manages users and their roles/permissions.

The UI would consult the User Services in order to tailor the UI.
Similarly, other microservices would query the user service in order to verify that the user is authorized to perform a particular request.

------

Then there is the point I mentioned above. If you have a single service doing authorization for every other service, it has to know about all those other services. You have to model their domains somehow in that authorization service. If you add a new microservice, you have to modify the authorization service as well. I don't think that this will make your architecture more simple or easier to implement. Actually, I think that it will become more brittle and error-prone.


