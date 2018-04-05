Validation steps needed:

Check that the JWT is well formed
Check the signature
Validate the standard claims
Check the Client permissions (scopes)


subject: the user’s identity

Based on a token, your microservice needs to be able to create a principal object. This principal object needs to contain all the necessary info so the system can decide whether or not the request should be executed or not.

Using the security context the AccessDecisionManager will be able to make a decision whether or not the request should be performed. To enable this, we need to add spring security to our class path and add the @EnableResourceServer annotation to our application.

The one that’s used most often enables method security, which you enable by adding @EnableGlobalMethodSecurity(prePostEnabled = true) to your configuration.

```
@PreAuthorize("(authentication.principal.uuid == #uuid.toString()) or hasRole('ADMIN')")
User findByUuid(@Param("uuid") UUID uuid);
```


