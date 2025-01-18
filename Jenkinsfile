pipeline {
    agent any

    tools {go '1.23.4'}

    stages {
        stage('Unit Testing') {
            steps {
                echo 'Testing...'
                sh 'go test ./app/test '
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'docker build -t go-pipeline-demo .' 
                withCredentials([usernamePassword(credentialsId: 'docker-hub-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                sh 'docker tag go-pipeline-demo $USERNAME/go-pipeline-demo'
                sh 'docker push $USERNAME/go-pipeline-demo'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                def dockerCmd = "docker run -p 3080:3080 -d ${IMAGE_NAME}"
                sshagent(['ec2-server-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@51.44.136.60 ${dockerCmd}"
                }
            }
        }
    }
}