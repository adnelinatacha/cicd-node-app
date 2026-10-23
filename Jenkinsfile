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
                  npm install &&
                  pm2 delete test-node-app || true &&
                  pm2 start npm --name test-node-app -- start &&
                  sleep 2 &&
                  pm2 list &&
                  curl -s http://localhost:3000 | head -20
                "
                '''
            }
        }
    }
}
