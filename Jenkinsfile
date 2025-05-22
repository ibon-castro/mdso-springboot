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
