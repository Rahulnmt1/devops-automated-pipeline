pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build with Maven') {
            steps {
                echo "Simulating a Maven build process for a Java application..."
                // In a real scenario, you would run: sh 'mvn clean install'
                sh 'echo "Maven build successful!"'
            }
        }

        stage('Deploy Infrastructure & Application') {
            steps {
                script {
                    echo "Executing deployment script..."
                    // Ensure the deploy script is executable
                    sh 'chmod +x deploy.sh'
                    // Run the deployment
                    sh './deploy.sh'
                }
            }
        }
    }
}