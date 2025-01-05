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
                // sh 'go build -o ./bin/app ./app/main.go'
                sh 'docker build -t go-pipeline-demo .' 
                sh 'docker run -p 3000:3000 go-pipeline-demo'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}