pipeline {
    agent any

    tools {
        // Use names you configured in Global Tool Configuration
        jdk 'JDK'
        maven 'MVN'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ibon-castro/mdso-springboot.git'
            }
        }

                stage('Semgrep Scan') {
            steps {
                // Install Semgrep if not already installed
                sh '''
                    if ! command -v semgrep &> /dev/null; then
                        pip install semgrep
                    fi
                '''

                // Run semgrep with default rules
                sh 'semgrep scan --config=auto --json > semgrep-report.json'
            }
        }


        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy') {
            steps {
                sh 'mvn spring-boot:run'
            }
        }
    }
}
