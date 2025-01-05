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
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                withCredentials([usernamePassword(credentials: 'docker-hub-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker tag go-pipeline-demo $USERNAME/go-pipeline-demo'
                    sh 'docker push $USERNAME/go-pipeline-demo'
                }
            }
        }
    }
}