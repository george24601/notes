const PI = 3.141593

//Block-scoped variables (and constants) without hoisting
for (let i = 0; i < a.length; i++) {
      let x = a[i]
}

odds  = evens.map(v => v + 1)
pairs = evens.map(v => ({ even: v, odd: v + 1 }))
nums  = evens.map((v, i) => v + i)

//default parameter values
function f (x, y = 7, z = 42) {
      return x + y + z
}

var customer = { name: "Foo" }

//string interpolation
var message = 'Hello ${customer.name}'

//Shorter syntax for common object property definition idiom
obj = { x, y }

//Intuitive and flexible destructuring of Arrays into individual variables during assignment.
var list = [ 1, 2, 3 ]
var [ a, , b ] = list
var { op, lhs, rhs } = getASTNode()

//Fail-soft destructuring, optionally with defaults.
var list = [ 7, 42 ]
var [ a = 1, b = 2, c = 3, d ] = list


//Support for exporting/importing values from/to modules without global namespace pollution.

//Iterator & For-Of Operator

//Generators

//Map/Set & WeakMap/WeakSet

//New functions for checking for non-numbers and finite numbers.

//Promises and its combination(!!!)


//proxy and reflection

