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
