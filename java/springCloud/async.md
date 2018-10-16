The @EnableAsync annotation switches on Spring’s ability to run @Async methods in a background thread pool. This class also customizes the used Executor.

By default, a SimpleAsyncTaskExecutor is used.

@Async has two limitations:

it must be applied to public methods only
self-invocation – calling the async method from within the same class – won’t work

@Async can also be applied to a method with return type – by wrapping the actual return in the Future

