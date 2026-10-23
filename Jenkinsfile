pipeline {
    agent any
    tools {
        nodejs 'node'
    }
    stages {
        stage('Install') {
            steps {
                sh 'npm install'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar_qube') {
                    sh 'sonar-scanner'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo deploy'
            }
        }
    }
}
