FROM golang:latest

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Fetch dependencies
RUN go mod tidy

# Build the Go app
RUN go build -o myapp ./app/main.go

# Make port 80 available to the world outside this container
EXPOSE 3000

# Run the Go app when the container launches
CMD ["./myapp"]