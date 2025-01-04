pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Testing go app...'
                sh 'ls'
                sh 'cd app'
                sh 'ls'
                sh 'go test ./test'
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