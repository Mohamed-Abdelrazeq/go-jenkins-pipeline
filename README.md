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
- 🚧 Create build script
- 🚧 Create test script
- 🚧 Create deploy script

## Development Steps
- Create local jenkins server on docker container
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

        volumes:
          jenkins_home:
        ```
    - Run
    
        ```sh
        docker compose up
        ```

- Install Gitlab Plugin 
    - Configure Gitlab in jenkins to read from the repository 
    - Create access token/User and Password credintials
- Install golang Plugin
    - Add golang version in jenkins
- Create Jenkinsfile 
    - Add golang to tools
    - Choose the version you created
- Run test in first stage
- Install Docker Plugin
- Create Dockerfile
- Build app in second stage 
