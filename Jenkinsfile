pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "adtelnatacha01devops/test-node"
        ANSIBLE_SERVER = "ansible@10.40.202.32"
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/adnelinatacha/cicd-node-app.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh 'docker push ${DOCKER_IMAGE_NAME}:${IMAGE_TAG}'
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ${ANSIBLE_SERVER} "cd /home/ansible/cicd-node-app && ansible-playbook deploy.yml --extra-vars \\"docker_image=${DOCKER_IMAGE_NAME}:${IMAGE_TAG}\\""
                    '''
                }
            }
        }
    }
}
