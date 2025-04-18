.PHONY: all clean

# Set the name of the executable
EXECUTABLE := main.out

# Set the default goal
all: $(EXECUTABLE) run

# Compile the Go program into an executable
$(EXECUTABLE):
	go build -o $(EXECUTABLE) main.go

# Run the executable
run:
	./$(EXECUTABLE)

test:
	go test -coverprofile=coverage.out

html:
	go tool cover -html=coverage.out


# Clean up by removing the executable
clean:
	rm -f $(EXECUTABLE)