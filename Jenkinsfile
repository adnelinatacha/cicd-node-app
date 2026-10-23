pipeline {
    agent any
    stages {
        stage('Checkout') { steps { checkout scm } }
        stage('Build et Deploy sur le vieux host') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "
                  cd /home/ansible/cicd-node-app &&
                  git pull &&
                  docker rm -f test-node-app || true &&
                  docker build -t test-node:latest . &&
                  docker run -d --name test-node-app -p 3000:3000 test-node:latest
                "
                '''
            }
        }
    }
}
