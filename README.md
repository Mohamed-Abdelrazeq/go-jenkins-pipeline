# Go Pipeline Demo

## Overview
This project demonstrates a CI/CD pipeline using Jenkins, Golang, Docker, and AWS. The pipeline automates the process of testing, building, and deploying a Go application. Infrastructure provisioning is managed using Terraform.

## Technologies Used
- Jenkins
- Golang
- AWS
- Terraform
- Docker
- Bash

## Pipeline Overview
The Jenkins pipeline is designed to automate the following steps:
1. **GitLab**: GitLab notifies Jenkins that new code has been merged to the master branch.
2. **Checkout Code**: Jenkins pulls the latest code from the GitLab repository.
3. **Test**: Runs unit tests to ensure code quality.
4. **Build**: Compiles the Go application.
5. **Dockerize**: Builds a Docker image for the application.
6. **Push to Docker Hub**: Pushes the Docker image to Docker Hub.
7. **SSH to Deployment Server**: Connect to the deployment server via SSH and run the Dockerized application.
8. **Deploy**: Deploys the Docker container to AWS EC2.

## Terraform Infrastructure
Terraform is used to provision the following AWS resources:
- **VPC**: A Virtual Private Cloud to host the infrastructure.
- **Security Groups**: Define firewall rules to control inbound and outbound traffic to the instances.
- **EC2 Instances**: Instances to run the Jenkins server and EC2 tasks.
- **IAM Roles**: Roles and policies to manage permissions for AWS services.

## AWS Services Used
- **ECS (Elastic Container Service)**: Manages Docker containers.
- **ECR (Elastic Container Registry)**: Stores Docker images.
- **EC2 (Elastic Compute Cloud)**: Hosts Jenkins and EC2 tasks.
- **VPC (Virtual Private Cloud)**: Isolates the network environment.
- **IAM (Identity and Access Management)**: Manages permissions and roles.
- **EIP (Elastic IP)**: Allocates a static IP address for the Jenkins server.


## My Development Steps
1. **Create local Jenkins server on Docker container**
  - Create a `docker-compose.yml` file:
    ```yaml
    version: '3.8'

    services:
     jenkins:
      build: .
      container_name: jenkins
      ports:
        - "8080:8080"
        - "50000:50000"
      volumes:
        - jenkins_home:/var/jenkins_home
        - /var/run/docker.sock:/var/run/docker.sock

    volumes:
     jenkins_home:
    ```

2. **Connect Jenkins to GitLab**
  - Configure Jenkins to pull code from the GitLab repository.

3. **Create test script**
    - Write a script to run Go unit tests:
        ```bash
        #!/bin/bash
        echo "Running Go unit tests..."
        go test ./... -v
        ```

4. **Create build script**
    - Write a script to compile the Go application:
        ```bash
        #!/bin/bash
        echo "Building Go application..."
        go build -o app .
        ```

5. **Create deploy script**
    - Write a script to deploy the Docker container to AWS EC2:
        ```bash
        #!/bin/bash
        echo "Deploying Docker container to AWS EC2..."
        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
        docker build -t $DOCKER_IMAGE_NAME .
        docker tag $DOCKER_IMAGE_NAME $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest
        docker push $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest

        ssh -i $EC2_KEY_PAIR $EC2_USER@$EC2_HOST << 'EOF'
        docker pull $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest
        docker stop app || true
        docker rm app || true
        docker run -d --name app -p 80:80 $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest
        EOF
        ```

6. **Create Terraform for AWS to host Jenkins**
    - Write Terraform configuration files to provision AWS resources:
        - **VPC**: Define a Virtual Private Cloud to host the Jenkins server.
        - **Subnets**: Create public and private subnets within the VPC.
        - **Security Groups**: Set up security groups to allow necessary traffic to the Jenkins server.
        - **EC2 Instance**: Provision an EC2 instance to run the Jenkins server.
        - **IAM Roles**: Create IAM roles and policies to grant the Jenkins server necessary permissions.
        - **EIP**: Allocate an Elastic IP for the Jenkins server to ensure a static IP address.

7. **Adjust the Jenkins file to deploy to EC2**
- **Install docker on the first boot**
```hcl
# Ensure Docker is installed on the first boot using user data
resource "aws_instance" "jenkins_server" {
    ami           = "ami-0c55b159cbfafe1f0" # Example AMI ID
    instance_type = "t2.micro"
    key_name      = var.ec2_key_pair

    user_data = <<-EOF
                            #!/bin/bash
                            sudo yum update -y
                            sudo amazon-linux-extras install docker -y
                            sudo service docker start
                            sudo usermod -a -G docker ec2-user
                            EOF

    tags = {
        Name = "JenkinsServer"
    }
}
```
- **SSH to Deployment EC2 Instance**: Connect to the EC2 instance designated for deployment.
- **Pull New Image**: Retrieve the latest Docker image from Docker Hub.
- **Run Docker Container**: Start the Docker container on the specified ports.

## TODO List
- ✅ Setup Jenkins
- ✅ Connect Jenkins to GitLab
- ✅ Create test script
- ✅ Create build script
- ✅ Create deploy script
- ✅ Create Terraform for AWS to host Jenkins
- ✅ Adjust the Jenkins file to deploy to EC2
