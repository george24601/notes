How spring inits object - create instance, pre-init,  create Bean instance, post-init, porcess annotation and inject properties

When creates proxy class, will as CGLib to create a new class on Runtime. Inheritanc uses cglib's dynamic deletitation, composition sues jvm's own dynamic delegation

Spring transaction need us to config a transactional manager, which in turn requires us to inject DataSource

every web project has a ServletContext - our listener listens to it. Listener will load spring config, and put created object into ServletContext

When a bean is a singleton, only one shared instance of the bean will be managed, and all requests for beans with an id or ids matching that bean definition will result in that one specific bean instance being returned by the Spring container.

By default, Spring works by creating one instance of each bean.

You can think of them as all being created as the ApplicationContext initialises

Beans can be configured as (scope) prototype beans - and for those, each time they are injected, a new instance is created. But that is not the default, and it's not all that commonly used.

controller is a singleton, so may have threadsafety probiel

bean scope: singleton, prototype, request....

