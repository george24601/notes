package main

import "fmt"

func swap(x, y string) (string, string) {
	return y, x
}

//use it only in short functions
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

func pow(x, n, lim float64) float64 {
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
	//equvalent of 	c, python, java := true, false, "no!"
	//similarly, variable can be decalred as var
	var c, python, java = true, false, "no!"
	var i, j int = 1, 2
	a, b := swap("hello", "world")
	fmt.Println(a, b)

	v := Vertex{1, 2}
	v.X = 4
	fmt.Println(v.X)

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

	b := make([]int, 0, 5) // len(b)=0, cap(b)=5

	m = make(map[string]Vertex)

	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}

	/*
		func (v Vertex) Abs() float64 {
			return math.Sqrt(v.X*v.X + v.Y*v.Y)
		}
	*/

}

//A defer statement defers the execution of a function until the surrounding function returns.

// This expression creates a slice of the first five elements of the array a: a[0:5]

//while methods with pointer receivers take either a value or a pointer as the receiver when they are called:
//while methods with value receivers take either a value or a pointer as the receiver when they are called:
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
