//each concrete class has to be a @Component too
public abstract class Runner{
	public abstract void run()
}

@Component
public class RunnerPicker implments AplicationContextAare{
	private Map map = new HashMap();

	public Runner pick(String type) {
		return map.get(type)
	}

	@PostConstruct
	public void register() {
		Map runnerMap = context.getBeansOfType(Runner.class);

		for(runner: runnerMap.values()){
			map.put(runner.support, runner);
		}

	}

	@Override
	public void setApplicationContext(applicaitonContext) {
		this.context=applicationContext;
	}
}

/* another approach
 */

@Component
@HandlerType("1")
public class NormalHandler extends AbstractHandler {

	@Overrride
	public String handle(OrderDTO dto) {
		return "process"

	}
}

@Target(ElementType.Type)
@Retenion(RetentionPolicy.RUNTIME)
@DOcumented
@Inherited
public @Interface HandlerType {
	String value();
}

@Component
@SuppressWaring("unchecked")
public class HandlePRocessor implements BeanFactoryPostProcesser {
	@Override
	public void postProcessBeanFactory(){
		Map<String, Class> HandlerMap;
		ClassScanner.scan(HANDLER_PACKAGE, HanderlType.class).forEach(clazz -> {
			String type = clazzz.getAnnotation(HandlerType.class).value();
			handlerMap.put(type.clazz);
		})

		HandlerContext context = new HandlerContext(handlerMap);
		beanFactory.registerSingleton(HandlerContext.class.getName(), context);
	}

}

public class HandlerContext{
	private Map<String, Class> handlerMap;

	public HandlerContext(Map<String, Class> handlerMap) {
	}

	public AbstractHandler getInstance(String type){
		BeanTool.getBean(hanlerMap.get(type))
	}

}
