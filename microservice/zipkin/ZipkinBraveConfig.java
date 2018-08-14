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
