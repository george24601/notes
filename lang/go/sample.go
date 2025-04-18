package main

// it is good style to use the factored import statement.
import (
	"fmt"
	"math"
	"strconv"
	"time"
)

// When two or more consecutive named function parameters share a type, you can omit the type from all but the last.
func swap(x, y string) (string, string) {
	return y, x
}

// Naked return statements should be used only in short functions
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

func pow(x, n, lim float64) float64 {
	// a name is exported if it begins with a capital letter.
	//the if statement can start with a short statement to execute before the condition.
	// Variables declared by the statement are only in scope until the end of the if
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return lim
}

type Vertex struct {
	X int
	Y int
}

var m map[string]Vertex

func main() {
	fmt.Println("The time is", time.Now())
	// If an initializer is present, the type can be omitted
	var c, python, java = true, false, "no!"
	var i, j int = 1, 2
	//Inside a function, short assignment statement can be used in place of a var declaration with implicit type
	a, b := swap("hello", "world")
	fmt.Println(a, b)

	//i := 42
	f := float64(i)
	u := uint(f)

	// The init and post statements are optional.
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	// At that point you can drop the semicolons: C's while is spelled for in Go.
	sum = 1
	for sum < 1000 {
		sum += sum
	}

	v := Vertex{1, 2}
	v2 = Vertex{X: 1} // Y:0 is implicit
	p := &v
	p.X = 1e9
	v.X = 4
	fmt.Println(v.X)

	primes := [6]int{2, 3, 5, 7, 11, 13}
	// includes the first element, but excludes the last one.
	//The default is zero for the low bound and the length of the slice for the high bound.
	//The zero value of a slice is nil.
	// A slice does not store any data, it just describes a section of an underlying array
	var s []int = primes[1:4]

	//slice literals
	s := []struct {
		i int
		b bool
	}{
		{2, true},
		{3, false},
		{5, true},
		{7, true},
		{11, false},
		{13, true},
	}

	// Slices of slices
	board := [][]string{
		[]string{"_", "_", "_"},
	}

	//how you create dynamically-sized arrays.
	b := make([]int, 0, 5) // len(b)=0, cap(b)=5

	var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}

	for i := range pow {
		pow[i] = 1 << uint(i) // == 2**i
	}
	for _, value := range pow {
		fmt.Printf("%d\n", value)
	}

	m = make(map[string]Vertex)
	m["Bell Labs"] = Vertex{
		40.68433, -74.39967,
	}

	//map literals
	var m = map[string]Vertex{
		"Bell Labs": Vertex{
			40.68433, -74.39967,
		},
		"Google": Vertex{
			37.42202, -122.08408,
		},
	}

	//If the top-level type is just a type name, you can omit it from the elements of the literal.
	var m = map[string]Vertex{
		"Bell Labs": {40.68433, -74.39967},
		"Google":    {37.42202, -122.08408},
	}

	elem, ok := m[key]

	//To test whether an interface value holds a specific type, a type assertion can return two values: the underlying value and a boolean value that reports whether the assertion succeeded.
	t, ok := i.(T)

	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}

	//Go interprets the statement v.Scale(5) as (&v).Scale(5) since the Scale method has a pointer receiver.
	v.Scale(5) // OK
	p := &v
	p.Scale(10) // OK

	// methods with value receivers take either a value or a pointer as the receiver when they are called
	fmt.Println(v.Abs()) // OK
	p := &v
	fmt.Println(p.Abs()) // OK

	var a Abser
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat implements Abser
	a = &v // a *Vertex implements Abser

	i, err := strconv.Atoi("42")
	if err != nil {
		fmt.Printf("couldn't convert number: %v\n", err)
		return
	}
	fmt.Println("Converted integer:", i)
}

// in Go it is common to write methods that gracefully handle being called with a nil receiver (as with the method M in this example.)
func (t *T) M() {
	if t == nil {
		fmt.Println("<nil>")
		return
	}
	fmt.Println(t.S)
}

// A type switch is like a regular switch statement, but the cases in a type switch specify types (not values), and those values are compared against the type of the value held by the given interface value
func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}

// A Stringer is a type that can describe itself as a string. The fmt package (and many others) look for this interface to print values.
func (p Person) String() string {
	return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

// As with fmt.Stringer, the fmt package looks for the error interface when printing values.
func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s",
		e.When, e.What)
}

//A defer statement defers the execution of a function until the surrounding function returns.

// This expression creates a slice of the first five elements of the array a: a[0:5]

// while methods with pointer receivers take either a value or a pointer as the receiver when they are called:
// while methods with value receivers take either a value or a pointer as the receiver when they are called:
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

// Go does not have classes. However, you can define methods on types.
// A method is a function with a special receiver argument.
func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// Methods with pointer receivers can modify the value to which the receiver points (as Scale does here). Since methods often need to modify their receiver, pointer receivers are more common than value receivers.
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

type Abser interface {
	Abs() float64
}

//A type implements an interface by implementing its methods. There is no explicit declaration of intent, no "implements" keyword.

/*
In some languages this would trigger a null pointer exception, but in Go it is common to write methods that gracefully handle being called with a nil receiver (as with the method M in this example.)
*/

/*
A Stringer is a type that can describe itself as a string. The fmt package (and many others) look for this interface to print values.
*/

/*
i, err := strconv.Atoi("42")
if err != nil {
	    fmt.Printf("couldn't convert number: %v\n", err)
	        return
	}
*/

//A goroutine is a lightweight thread managed by the Go runtime.
