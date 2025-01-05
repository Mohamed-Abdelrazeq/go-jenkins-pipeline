# Go Pipeline Demo

## Technologies Used
- Jenkins
- Golang
- AWS
- Terraform
- Docker

## TODO List
- ✅ Create EC2 instance
- ✅ Setup Jenkins
- ✅ Connect Jenkins to GitLab
- ✅ Create test script
- ✅ Create build script
- 🚧 Create deploy script

## Development Steps
- Create local Jenkins server on Docker container
  - Create a `docker-compose.yml` file

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
  - Run
  
    ```sh
    docker compose up
    ```

- Install GitLab Plugin 
  - Configure GitLab in Jenkins to read from the repository 
  - Create access token/User and Password credentials
- Install Golang Plugin
  - Add Golang version in Jenkins
- Create Jenkinsfile 
  - Add Golang to tools
  - Choose the version you created
- Run test in the first stage
- Install Docker on the Jenkins server 
  - Access root user using:
  ```sh
  docker exec -u 0 -it 45833 bash
  ```
  - Notice we created a volume to let Jenkins access `docker.sock` on the host device
  - Run
  ```sh
  apt-get update 
  apt install docker.io -y
  docker --version
  ```
- Create Dockerfile
- Build app in the second stage 

