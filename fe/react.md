### useRef

### useLayoutEffect

However, not all effects can be deferred. For example, a DOM mutation that is visible to the user must fire synchronously before the next paint so that the user does not perceive a visual inconsistency. (The distinction is conceptually similar to passive versus active event listeners.) For these types of effects, React provides one additional Hook called useLayoutEffect. It has the same signature as useEffect, and only differs in when it is fired.

### portal

### import vs require

Use <Link> instead of <a> to reduce re-rendering


Use Multiple Effects to Separate Concerns

Often, effects create resources that need to be cleaned up before the component leaves the screen, such as a subscription or timer ID. To do this, the function passed to useEffect may return a clean-up function. 

The clean-up function runs before the component is removed from the UI to prevent memory leaks. Additionally, if a component renders multiple times (as they typically do), the previous effect is cleaned up before executing the next effect. In our example, this means a new subscription is created on every update. 

If a function’s name starts with ”use” and it calls other Hooks, we say it is a custom Hook. The useSomething naming convention is how our linter plugin is able to find bugs in the code using Hooks.

Because this.props and this.state may be updated asynchronously, you should not rely on their values for calculating the next state.

Keys help React identify which items have changed, are added, or are removed. Keys should be given to the elements inside the array to give the elements a stable identity:

The best way to pick a key is to use a string that uniquely identifies a list item among its siblings. Most often you would use IDs from your data as keys

We don’t recommend using indexes for keys if the order of items may change. This can negatively impact performance and may cause issues with component state.                                                                           

