@Configuration
public class SleuthConversationConfiguration {
  public static final String TAG_NAME = "X-B3-CONVID";

  @Bean
  @Order(TraceFilter.ORDER + 5)
  public GenericFilterBean customTraceFilter(final Tracer tracer) {
    return new GenericFilterBean() {

      @Override
      public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
          FilterChain filterChain) throws IOException, ServletException {
        Span span = tracer.getCurrentSpan();
        String existingConversationId = span.getBaggage().get(TAG_NAME.toLowerCase());
        if(existingConversationId == null){
          existingConversationId = UUID.randomUUID().toString();
          span.setBaggageItem(TAG_NAME, existingConversationId);
        }
        tracer.addTag(TAG_NAME, existingConversationId);
	//Further, you need to ensure that you add this extra field in your logback configuration (or any log configuration you may use) of all the services that use it by using %X{X-B3-CONVID:-} as property value; else you will not see it in your logs!
        MDC.put(TAG_NAME, existingConversationId);
        tracer.continueSpan(span);
        filterChain.doFilter(servletRequest, servletResponse);
      }
    };
  }
}

//The key to get the spanId and traceId put in the MDC is in this section of the ZipkinBraveConfiguration.java file
//The Brave library provides an MDCCurrentTraceContext which can be set on the tracing object. We use the MDCCurrentTraceContext, because we use SLF4J as our logging framework. If you are using Log4j-2 directly, you can use ThreadContextCurrentTraceContext instead.
@Bean
public Tracing tracing() {
    val tracing = Tracing.newBuilder()
            .localServiceName(serviceName)
            .currentTraceContext(MDCCurrentTraceContext.create());

    if (zipkinEnabled) {
        tracing.reporter(reporter());
    }
    return tracing.build();
}

///setting baggage on a span
Span initialSpan = this.tracer.nextSpan().name("span").start();
ExtraFieldPropagation.set(initialSpan.context(), "foo", "bar");
ExtraFieldPropagation.set(initialSpan.context(),"UPPER_CASE", "someValue");


