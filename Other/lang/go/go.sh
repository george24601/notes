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

# If you include the repository URL in the package's import path, go get will fetch, build, and install it automatically
$GOPATH/bin/hello
