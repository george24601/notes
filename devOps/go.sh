#add the workspace's bin subdirectory to your PATH: 
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

mkdir -p $GOPATH/src/github.com/user

mkdir $GOPATH/src/github.com/user/hello

#after creating the hello.go
#Now you can build and install that program with the go tool:
go install github.com/user/hello

#now can run the program
$GOPATH/bin/hello

<<Test 
You write a test by creating a file with a name ending in _test.go that contains functions named TestXXX with signature func (t *testing.T). The test framework runs each such function; if the function calls a failure function such as t.Error or t.Fail, the test is considered to have failed.
Test

# If you include the repository URL in the package's import path, go get will fetch, build, and install it automatically
$GOPATH/bin/hello

#The imports in hello.go file use the same import path convention, so the go get command is able to locate and install the dependent package, too.


