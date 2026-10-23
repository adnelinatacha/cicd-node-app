pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "
                  cd /home/ansible/cicd-node-app &&
                  git pull origin main &&
                  docker rm -f test-node-app || true &&
                  DOCKER_BUILDKIT=1 docker build --security-opt apparmor=unconfined --security-opt seccomp=unconfined -t test-node:latest . &&
                  docker run -d --name test-node-app -p 3000:3000 --security-opt apparmor=unconfined --security-opt seccomp=unconfined test-node:latest &&
                  sleep 2 && docker ps | grep test-node
                "
                '''
            }
        }
 
   }
}
