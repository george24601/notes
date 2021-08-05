import React, { useState, useEffect } from 'react';

//This is one of the traits of async functions — their return values are guaranteed to be converted to promises.
let hello = async () => { return "Hello" };


function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }

  useEffect(() => {
    ChatAPI.subscribeToFriendStatus(friendID, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  return isOnline;
}

// The defaultValue argument is only used when a component does not have a matching Provider above it in the tree. This default value can be helpful for testing components in isolation without wrapping them. Note: passing undefined as a Provider value does not cause consuming components to use defaultValue.
const MyContext = React.createContext(defaultValue);



  // Correct
this.setState((state, props) => ({
    counter: state.counter + props.increment
  }));

  // Correct
this.setState(function(state, props) {
    return {
      counter: state.counter + props.increment
    };
  });

////
enum Color {
  Green = "Green",
  Red = "Red"
}

//const colorEnum = "Blue" as Color won't error, and you would be left thinking that colorEnum is OK. But if you were to console.log it, you'd see "Blue"
const color = "Green";
const colorEnum = color as Color;

////
  const user = {
    firstName: 'Harper',
    lastName: 'Perez'
  };
  
  const element = (
    <h1>
      Hello, {formatName(user)}!
    </h1>
  );

<Parent key="value">
              <Children />
            </Parent>


//also note the index signature in typescript
export const configs = {
  [MyEnum.EnumV]: {
	k1 : 'Value'
}
}

const enumVSet = new Set(Object.values(MyEnum) as string[])

const myEnum = nullableV ? (nullableV as MyEnum) : undefined
const stringV: string = optionalV ?? ''

<div className={classNames({
styleSelector : true })}
>
</div>

//Comparing with string enum
stringV !== StringEnum.Val
