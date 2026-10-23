pipeline {
    agent any
    stages {
       
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar_qube') {
                    sh 'sonar-scanner'
                }
            }
        }


               stage('SonarQube Analysis') { ... }
        stage('Deploy') { ... }
    }
}
     stage('Deploy') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "
                  cd /home/ansible/cicd-node-app
                  git pull origin main
                  docker rm -f test-node-app || true
                  docker build -t test-node:latest .
                  docker run -d --privileged --security-opt apparmor=unconfined --name test-node-app -p 3000:3000 test-node:latest
                  sleep 5
                  docker ps
                  docker logs test-node-app --tail 30
                "
                '''
            }
        }
    }
}
