Cadence does not recover activity state in case of failures. 

Similarly, when a workflow needs to handle an external event, a decision task is created. A decision task list is used to deliver it to the workflow worker (also called decider).

The main one is that they do not require explicit registration and are created on demand. The number of task lists is not limited. A common use case is to have a task list per worker process and use it to deliver activity tasks to the process. Another use case is to have a task list per pool of workers.

@WorkflowMethod indicates an entry point to a workflow. It contains parameters such as timeouts and a task list. Required parameters (such as executionStartToCloseTimeoutSeconds) that are not specified through the annotation must be provided at runtime.

A workflow interface that executes a workflow requires initializing a WorkflowClient instance, creating a client side stub to the workflow, and then calling a method annotated with @WorkflowMethod.

There are two ways to start workflow execution asynchronously and synchronously. Asynchronous start initiates a workflow execution and immediately returns to the caller. This is the most common way to start workflows in production code.

A single instance of an activity object is registered per activity interface type. This means that the activity implementation should be thread-safe since the activity method can be simultaneously called from multiple threads.
A single instance of the activities implementation is shared across multiple simultaneous activity invocations. Therefore, the activity implementation code must be thread safe.

The entire execution history is transferred from the Cadence service to workflow workers when a workflow state needs to recover. A large execution history can thus adversely impact the performance of your workflow. Therefore, be mindful of the amount of data you transfer via activity invocation parameters or return values.


Do not use any mutable global variables because multiple instances of workflows are executed in parallel.
Do not call any non-deterministic functions like non seeded random or UUID.randomUUID() directly from the workflow code.

Don’t perform any IO or service calls as they are not usually deterministic. Use activities for this.
Only use Workflow.currentTimeMillis() to get the current time inside a workflow.
Do not use native Java Thread or any other multi-threaded classes like ThreadPoolExecutor. Use Async.function or Async.procedure to execute code asynchronously.

Don't use any synchronization, locks, and other standard Java blocking concurrency-related classes besides those provided by the Workflow class. There is no need in explicit synchronization because multi-threaded code inside a workflow is executed one thread at a time and under a global lock.
Call WorkflowThread.sleep instead of Thread.sleep.
Use Promise and CompletablePromise instead of Future and CompletableFuture.
Use WorkflowQueue instead of BlockingQueue.
Use Workflow.getVersion when making any changes to the workflow code. Without this, any deployment of updated workflow code might break already open workflows.

Components:
front end + matching service + history service:

tasklist goes to matching service
matching service: schedule activity task, task dispatch

Storage:
task(matching), events, workflow, visibility (history)

history service: mutable workflow state, transfer q, timer q


