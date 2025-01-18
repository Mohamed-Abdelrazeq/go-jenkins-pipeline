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
- ✅ Create Terraform for AWS to host Jenkins
-    Make docker image run on every boot 
-    Isolate the jenkins in EBS
-    Add ECS to Terraform to host the app on
-    Adjust the Jenkins file to deploy to ECS

## Development Steps
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
  - Run:
    ```sh
    docker compose up
    ```

2. **Install GitLab Plugin**
  - Configure GitLab in Jenkins to read from the repository.
  - Create access token/User and Password credentials.

3. **Install Golang Plugin**
  - Add Golang version in Jenkins.

4. **Create Jenkinsfile**
  - Add Golang to tools.
  - Choose the version you created.
  - Run test in the first stage.

5. **Install Docker on the Jenkins server**
  - Access root user using:
    ```sh
    docker exec -u 0 -it 45833 bash
    ```
  - Notice we created a volume to let Jenkins access `docker.sock` on the host device.
  - Run:
    ```sh
    apt-get update 
    apt install docker.io -y
    docker --version
    ```

6. **Create Dockerfile**

7. **Add Docker Hub credentials to Jenkins**

8. **Build app in the second stage**

9. **Deploy the app by pushing to your repository in the last stage**

10. **Start working on Terraform to setup Jenkins server on EC2 and deploy the app to another EC2**
   - User Data is used to install Docker and create Jenkins container.
   - Tried t2.micro but it struggled with the Jenkins load.
   - Switching to t2.medium was sufficient but the cost is 3/4 times more.
   - Test:
    ```sh
    cat /var/log/cloud-init-output.log
    ```

   - User Data script:
    ```sh
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
    sudo docker exec -u 0 jenkins /bin/sh -c "apt-get update && apt install docker.io -y && docker --version"
    ```

11. **Always restart jenkins contaienr && auto start docker daemon**
  - Adjust -> docker run --restart=always -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts
  - Add -> systemctl enable /usr/lib/systemd/system/docker.service


    