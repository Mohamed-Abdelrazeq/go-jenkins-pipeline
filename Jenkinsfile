pipeline {
    agent any

    tools {go '1.23.4'}

    stages {
        stage('Test') {
            steps {
                echo 'Testing go app...'
                sh 'go mod init github.com/Mohamed-Abdelrazeq/go-pipeline-demo'
                sh 'go mod tidy'
                sh 'go test ./app/test '
            }
        }
        stage('Build') {
            steps {
                echo 'Building go app...'
                sh 'pwd'
                // sh 'go build -o myapp'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}