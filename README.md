# Go Pipeline Demo

## Technologies Used
- Jenkins
- Golang
- AWS
- Terraform
- Docker

## TODO List
- ✅ Setup Jenkins
- ✅ Connect Jenkins to GitLab
- ✅ Create test script
- ✅ Create build script
- ✅ Create deploy script
-    Create Terraform for AWS to host Jenkins

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
- Add docker hub credintials to Jenkins
- Build app in the second stage 
- Deploy the app by push to your repository in the last stage
- Start working on Terraform to setup Jenkins server on EC2 and Deploy the app to another EC2


```sh
cat /var/log/cloud-init-output.log
```

```sh
#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```