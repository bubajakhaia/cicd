pipeline {
    agent any
    
    tools {
        nodejs 'NodeJS 7.8.0'
    }
    
    environment {
        DOCKER_IMAGE = "${BRANCH_NAME == 'main' ? 'nodemain' : 'nodedev'}:v1.0"
        PORT = "${BRANCH_NAME == 'main' ? '3000' : '3001'}"
        ACTIVE_LOGO = "${BRANCH_NAME == 'main' ? 'src/logo.svg' : 'src/logo2.svg'}"
        CONTAINER_NAME = "${env.DOCKER_IMAGE.replace(':', '_')}" 
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${env.DOCKER_IMAGE} --build-arg LOGO_FILE=${env.ACTIVE_LOGO} ."
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    sh """
                    docker stop ${env.CONTAINER_NAME} || true
                    docker rm ${env.CONTAINER_NAME} || true
                    """
                    
                    sh """
                    docker run -d \
                        --name ${env.CONTAINER_NAME} \
                        -p ${env.PORT}:${env.PORT} \
                        ${env.DOCKER_IMAGE}
                    """
                }
            }
        }
    }
    
    post {
        always {
            echo "Deployed ${env.DOCKER_IMAGE} on port ${env.PORT}"
            echo "Using logo: ${env.ACTIVE_LOGO}"
        }
    }
}
