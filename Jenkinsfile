pipeline {
    agent any

    tools {go '1.23.4'}

    stages {
        stage('Unit Testing') {
            steps {
                echo 'Testing go app...'
                sh 'go test ./app/test '
            }
        }
        stage('Build') {
            steps {
                echo 'Building go app...'
                sh 'docker build -t go-pipeline-demo .' 
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}