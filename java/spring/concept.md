how is circular dependency solved?

How spring inits object - create instance, pre-init,  create Bean instance, post-init, porcess annotation and inject properties

Spring transaction need us to config a transactional manager, which in turn requires us to inject DataSource

every web project has a ServletContext - our listener listens to it. Listener will load spring config, and put created object into ServletContext

You can think of them as all being created as the ApplicationContext initialises

Beans can be configured as (scope) prototype beans - and for those, each time they are injected, a new instance is created. But that is not the default, and it's not all that commonly used.

bean scope: singleton, prototype, request....

use ApplicationEvent and ApplicationContext, ApplicationEventPubliserAware to decouple

### Session
* implemented a thread-safe hashmap, when browser visits, request will try fetching the jessionid and use that as the key
* CORS problem, JSONP
* Often implemented in HandlerInterceptor.preHandle()
```java
//during login, session.setAttribute("user", user1)
User user = (User) request.getSession().getAttribute("user") 

if(sessionUser == null){
//check loginToken from cookie, see if it exists and not expired

}
```
* accessToken Often goes together with refreshToken, so that user doesn't have to re-login every time the accessToken expires
