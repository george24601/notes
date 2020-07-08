Cadence does not recover activity state in case of failures. Therefore an activity function is allowed to contain any code without restrictions.

The Cadence service does not execute workflow code directly. The workflow code is hosted by an external (from the service point of view) workflow worker process. These processes receive decision tasks that contain events that the workflow is expected to handle from the Cadence service, delivers them to the workflow code, and communicates workflow decisions back to the service.

Activities are hosted by activity worker processes that receive activity tasks from the Cadence service, invoke correspondent activity implementations and report back task completion statuses.

When a workflow invokes an activity, it sends the ScheduleActivityTask decision to the Cadence service. As a result, the service updates the workflow state and dispatches an activity task to a worker that implements the activity. 
Similarly, when a workflow needs to handle an external event, a decision task is created. A decision task list is used to deliver it to the workflow worker (also called decider).

The main one is that they do not require explicit registration and are created on demand. The number of task lists is not limited. A common use case is to have a task list per worker process and use it to deliver activity tasks to the process. Another use case is to have a task list per pool of workers.


@WorkflowMethod indicates an entry point to a workflow. It contains parameters such as timeouts and a task list. Required parameters (such as executionStartToCloseTimeoutSeconds) that are not specified through the annotation must be provided at runtime.

A workflow implementation implements a workflow interface. Each time a new workflow execution is started, a new instance of the workflow implementation object is created. Then, one of the methods (depending on which workflow type has been started) annotated with @WorkflowMethod is invoked. As soon as this method returns, the workflow execution is closed. While workflow execution is open, it can receive calls to signal and query methods.

A workflow interface that executes a workflow requires initializing a WorkflowClient instance, creating a client side stub to the workflow, and then calling a method annotated with @WorkflowMethod.

There are two ways to start workflow execution asynchronously and synchronously. Asynchronous start initiates a workflow execution and immediately returns to the caller. This is the most common way to start workflows in production code.

A single instance of an activity object is registered per activity interface type. This means that the activity implementation should be thread-safe since the activity method can be simultaneously called from multiple threads.
A single instance of the activities implementation is shared across multiple simultaneous activity invocations. Therefore, the activity implementation code must be thread safe.

The values passed to activities through invocation parameters or returned through a result value are recorded in the execution history. The entire execution history is transferred from the Cadence service to workflow workers when a workflow state needs to recover. A large execution history can thus adversely impact the performance of your workflow. Therefore, be mindful of the amount of data you transfer via activity invocation parameters or return values.

activity task
A task that contains an activity invocation information that is delivered to an activity worker through and an activity task list. An activity worker upon receiving activity task executes a correponding activity

decision
Any action taken by the workflow durable function is called a decision. For example: scheduling an activity, canceling a child workflow, or starting a timer. A decision task contains an optional list of decisions. Every decision is recorded in the event history as an event.

decision task
Every time a new external event that might affect a workflow state is recorded, a decision task that contains it is added to a decision task list and then picked up by a workflow worker. After the new event is handled, the decision task is completed with a list of decision.

worker
Also known as a worker service. A service that hosts the workflow and activity implementations. The worker polls the Cadence service for tasks, performs those tasks, and communicates task execution results back to the Cadence service. Worker services are developed, deployed, and operated by Cadence customers.

workflow task
Synonym of the decision task.

workflow worker
An object that is executed in the client application and receives decision task from an decision task list it is subscribed to. Once task is received it is handled by a correponding workflow.

