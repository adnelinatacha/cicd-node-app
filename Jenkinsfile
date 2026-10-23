pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "adtelnatacha01devops/test-node:latest"
        TAR_FILE = "/tmp/test-node.tar"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Transfert image vers Ansible') {
            steps {
                sh '''
                  docker save $DOCKER_IMAGE -o $TAR_FILE
                  scp -o StrictHostKeyChecking=no $TAR_FILE ansible@10.40.202.32:/tmp/test-node.tar
                  ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "docker load -i /tmp/test-node.tar"
                '''
            }
        }
        stage('Deploiement avec Ansible') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no ansible@10.40.202.32 "cd /home/ansible/cicd-node-app && git pull && ansible-playbook deploy.yml --extra-vars \\"docker_image=$DOCKER_IMAGE\\""'
            }
        }
    }
}
