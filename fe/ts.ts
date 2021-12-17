/*
Named parameters: An argument is assigned to a parameter if they have the same name. JavaScript doesn’t have named parameters, but you can simulate them. For example, this is a function call with only (simulated) named arguments:
*/
selectEntries({start: 3, end: 20, step: 2})

function repeat1(...[str, times]: [string, number]): string {
  return str.repeat(times);
}

//A rest parameter collects all remaining parameters in an Array. Therefore, its static type is usually an Array.
function join(separator: string, ...parts: string[]) {
  return parts.join(separator);
}
assert.equal(
  join('-', 'state', 'of', 'the', 'art'),
  'state-of-the-art');


function trim1(str?: string): string {
  // Internal type of str:
  // %inferred-type: string | undefined
  str;

  if (str === undefined) {
    return '';
  }
  return str.trim();
}

interface StringArray {
  [index: number]: string;
}
const strArr: StringArray = ['Huey', 'Dewey', 'Louie'];

//If the Array has a fixed length and each element has a different, fixed type that depends on its position
const yes: [string, string, boolean] = ['oui', 'sí', true];

interface Interf {
  prop1?: string;
  prop2: undefined | string; 
}

//An optional property can do everything that undefined|string can. We can even use the value undefined for the former:
const obj1: Interf = { prop1: undefined, prop2: undefined };
//However, only .prop1 can be omitted:
const obj2: Interf = { prop2: undefined };



interface StringAndNumberKeys {
  [key: string]: Object;
  [key: number]: RegExp;
}

// %inferred-type: (x: StringAndNumberKeys) =>
// { str: Object; num: RegExp; }
function f(x: StringAndNumberKeys) {
  return { str: x['abc'], num: x[123] };
}

function translate(dict: TranslationDict, english: string): string {
  return dict[english];
}

interface TranslationDict {
  [key:string]: string; // (A)
}
const dict = {
  'yes': 'sí',
  'no': 'no',
  'maybe': 'tal vez',
};
assert.equal(
  translate(dict, 'maybe'),
  'tal vez');

/*
We can use the keyof type operator to create the type whose elements are the keys of the enum members. When we do so, we need to combine keyof with typeof:
*/
enum HttpRequestKeyEnum {
  'Accept',
  'Accept-Charset',
  'Accept-Datetime',
  'Accept-Encoding',
  'Accept-Language',
}
// %inferred-type: "Accept" | "Accept-Charset" | "Accept-Datetime" |
// "Accept-Encoding" | "Accept-Language"
type HttpRequestKey = keyof typeof HttpRequestKeyEnum;

function getRequestHeaderValue(request: Request, key: HttpRequestKey) {
  // ···
}

//This is a numeric enum without any initializers:

enum NoYes {
  No,
  Yes,
}
assert.equal(NoYes.No, 0);
assert.equal(NoYes.Yes, 1);

// Dynamic lookup:
assert.equal(NoYes['Yes'], 1);

//String-based enums

enum NoYes {
  No = 'No',
  Yes = 'Yes',
}

assert.equal(NoYes.No, 'No');
assert.equal(NoYes.Yes, 'Yes');

/*
We are not able to mutate the parameter which leads to zero side effects! Nice. But does this mean we can’t have function which sorts our arrays? Of course we can. We only need to sort a copy of our array rather than sorting the array itself. There are many ways to copy an array in JS like spreading it ([…array]),
*/
function sortNumbers(array: Readonly<Array<number>>) {
  return [...array].sort((a, b) => a - b)
}

type AllowedKeys = 'name' | 'age'

// use a type here instead of interface
type Person = Record<AllowedKeys, unknown>

const Human: Person = {
  name: 'Steve',
  age: 42,
}

/*
We can use an indexed access type to look up a specific property on another type
*/
type Person = { age: number; name: string; alive: boolean };
type Age = Person["age"]; //type Age = number
type I1 = Person["age" | "name"]; //type I1 = string | number
type I2 = Person[keyof Person]; //type I2 = string | number | boolean

const MyArray = [
  { name: "Alice", age: 15 },
  { name: "Bob", age: 23 },
  { name: "Eve", age: 38 },
];

/*
type Person = {
    name: string;
    age: number;
}
*/
type Person = typeof MyArray[number];

//Constructs a type with all properties of Type set to optional. This utility will return a type that represents all subsets of a given type.

interface Todo {
  title: string;
  description: string;
}
 
function updateTodo(todo: Todo, fieldsToUpdate: Partial<Todo>) {
  return { ...todo, ...fieldsToUpdate };
}
 
const todo1 = {
  title: "organize desk",
  description: "clear clutter",
};
 
const todo2 = updateTodo(todo1, {
  description: "throw out trash",
});

//Constructs a type consisting of all properties of Type set to required. The opposite of Partial.
interface Props {
  a?: number;
  b?: string;
}
 
const obj: Props = { a: 5 };
 
const obj2: Required<Props> = { a: 5 };



