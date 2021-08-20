import { useHistory } from "react-router-dom";

function HomeButton() {
  const history = useHistory();

  function handleClick() {
    history.push("/home");
  }

  return (
    <button type="button" onClick={handleClick}>
      Go home
    </button>
  );
}

//conditionally add properties
var component = (
  <div
    value="foo"
    { ...( condition && { disabled: true } ) } />
);


<Modal {...this.props} title='Modal heading' animation={false}>
//is equivalent to
<Modal a={this.props.a} b={this.props.b} title='Modal heading' animation={false}>

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


////
enum Color {
  Green = "Green",
  Red = "Red"
}

//const colorEnum = "Blue" as Color won't error, and you would be left thinking that colorEnum is OK. But if you were to console.log it, you'd see "Blue"
const color = "Green";
const colorEnum = color as Color;

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
