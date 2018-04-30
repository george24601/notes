//add this to zuul handler mapping
public static class ZuulHandlerBeanPostProcessor extends InstantiationAwareBeanPostProcessorAdapter {  

	@Value("${loginpatternsinclude}")  
	private String includePattern;  
	@Value("${loginpatternsexclude}")  
	private String excludePattern;  

	@Autowired  
	private AuthenticateInterceptor authenticateInterceptor;  


	public MappedInterceptor pattern(String[] includePatterns, String[] excludePatterns, HandlerInterceptor interceptor) {  
		return new MappedInterceptor(includePatterns, excludePatterns, interceptor);  
	}  

	//to support request path filtering
	@Override  
	public boolean postProcessAfterInstantiation(final Object bean, final String beanName) throws BeansException {  
		if (bean instanceof ZuulHandlerMapping) {  
			ZuulHandlerMapping zuulHandlerMapping = (ZuulHandlerMapping) bean;  
			String[] includePatterns = IterablestoArray(Splitteron(",")trimResults()omitEmptyStrings()split(includePattern), Stringclass);  
			String[] excludePatterns = IterablestoArray(Splitteron(",")trimResults()omitEmptyStrings()split(excludePattern), Stringclass);  
			zuulHandlerMappingsetInterceptors(pattern(includePatterns, excludePatterns, authenticateInterceptor));  
		}  
		return superpostProcessAfterInstantiation(bean, beanName);  
	}  

}
