On right-hand side, scroll down to "Event Listener Breakpoints", and expand tree
Click on the events you want to listen for.
Interact with the target element, if they fire you will get a break point in the debugger

The debugger can be activated from the code by using a debugger; statement. 

Select a component in React DevTools and pop open the console (hitting the escape key lets you see both at once). Type in $r, and you’ll have access to the instance of that React component from the console.

If you right-click a function in the props or state overview, you can make it available as a global variable. This way, you can call it whenever you want with different arguments and contexts.

When you’re creating custom React Hooks that are shared with other developers, it’s often a good idea to use the useDebugValue hook. This hook adds an informative label to the hook that shows up in the React DevTools.

a very common error which results in data being visible in “Network” tab but not accessible to your app is failing the CORS protocol.

The CORS error is especially tricky as it will show as a successful request (it will be white on the list) and all the data you expect will be there in “Preview” tab. To get around CORS “limitation” you need to either work with the backend provider (in order to allow CORS on the server, or configure it in a way that it can be used by your app) or use a proxy solution (CORS affects only browsers — any proxy written in a server-side language will just ignore it).

One of the most important features however lies in the update that React Developer Tools adds to the default “Console” window (if you don’t see it when on the “React” tab, click the three-dots icon and select “Show console drawer”). When an React element is selected you can use $r in the console which will give you this of the selected element:

You can interact with the element, call its methods and event handlers just like a normal interaction would. This feature allows you to change complex structures we mentioned earlier (e.g. you can select an element, call its $r.setState({message: 'Hello world!'}) which will trigger normal reconcilation process.

You can use getEventListeners(node) in the Console Panel to retrieve registered event listeners on the passed in DOM node. In addition to that, the video clip shows debug(listenerFunction) invoking the debugger when the listener is called

To exclude jquery from the call stack, black box the script: developer.chrome.com/devtools/docs/blackboxing 


To set a DOM change breakpoint:

Click the Elements tab.
Go the element that you want to set the breakpoint on.
Right-click the element.
Hover over Break on then select Subtree modifications, Attribute modifications, or Node removal.

Call debug(functionName), where functionName is the function you want to debug, when you want to pause whenever a specific function is called. You can insert debug() into your code (like a console.log() statement) or call it from the DevTools Console. debug() is equivalent to setting a line-of-code breakpoint on the first line of the function.

`
