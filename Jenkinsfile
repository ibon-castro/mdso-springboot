pipeline {
    agent any

    tools {
        jdk 'JDK'
        maven 'MVN'
    }

    environment {
        DEFECTDOJO_URL = 'http://localhost:8080/api/v2/import-scan/'
        SCAN_TYPE = 'Semgrep JSON Report'
        TEST_ID = '1'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ibon-castro/mdso-springboot.git'
            }
        }

        stage('Semgrep Scan') {
            steps {
                sh '''
                    docker run --rm -v $PWD:/src returntocorp/semgrep semgrep scan \
                      --config=auto --json > semgrep-report.json
                '''
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy') {
            steps {
                sh 'nohup mvn spring-boot:run > app.log 2>&1 &'
            }
        }
    }

    post {
        always {
            withCredentials([string(credentialsId: 'Defect_Dojo_Api_Key', variable: 'API_KEY')]) {
                script {
                    def reportFile = "semgrep-report.json"

                    sh """
                        curl -X POST \\
                          '${DEFECTDOJO_URL}' \\
                          -H 'accept: application/json' \\
                          -H 'Authorization: Token ${API_KEY}' \\
                          -H 'Content-Type: multipart/form-data' \\
                          -F 'file=@${reportFile};type=application/json' \\
                          -F 'scan_type=${SCAN_TYPE}' \\
                          -F 'test=${TEST_ID}' \\
                          -F 'product_name=mdso-springboot' \\
                          -F 'engagement_name=2025-06-06'
                    """
                }
            }
        }
    }
}
