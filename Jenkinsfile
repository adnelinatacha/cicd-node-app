pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "
                  cd /home/ansible/cicd-node-app
                  git pull origin main
                  docker rm -f test-node-app || true
                  docker build -t test-node:latest .
                  docker run -d --privileged --security-opt apparmor=unconfined --security-opt seccomp=unconfined --name test-node-app -p 3000:3000 test-node:latest
                  sleep 6
                  docker ps | grep test-node
                  docker logs test-node-app --tail 30
                "
                '''
            }
        }
    }
}
