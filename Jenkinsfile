pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "adtelnatacha01devops/test-node:latest"
    }
    stages {
        stage('Checkout') { 
            steps { checkout scm } 
        }
        stage('Build Docker Image') { 
            steps { sh 'docker build -t $DOCKER_IMAGE .' } 
        }
        stage('Push Docker Image') {
            steps {
                script {
                    try {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin && docker push $DOCKER_IMAGE || echo "Push timeout, on continue"'
                        }
                    } catch (e) {
                        echo "Credentials docker-hub non trouvés, on skip le push pour déployer quand même"
                    }
                }
            }
        }
        stage('Déploiement avec Ansible') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 ansible@10.40.202.32 "cd /home/ansible/cicd-node-app && git pull && ls -l && ansible-playbook deploy.yml --extra-vars \\"docker_image=adtelnatacha01devops/test-node:latest\\" "'
            }
        }
    }
}
