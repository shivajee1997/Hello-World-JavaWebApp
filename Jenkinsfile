pipeline {
    agent any
    tools {
        maven "Maven"
        jdk "JDK"
    }
    stages {
        stage('Pulling the code'){
            steps{
                echo "PATH = ${M2_HOME}/bin:${PATH}"
                echo "M2_HOME = /opt/maven"
            }
        }
        stage('Application Build') {
            steps {
                dir("${workspace}") {
                sh 'mvn -B -DskipTests clean package'
                }
            }
        }
        stage('Container Build') {
            steps {
                dir("${workspace}") {
                sh 'docker build . -t helloworldjavawebapp'
                }
            }
        }
        stage('Registry Auth') {
            steps {
                dir("${workspace}") {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 725482889936.dkr.ecr.us-east-1.amazonaws.com'
                }
            }
        }
        
     }
    post {
       always {
          junit(
        allowEmptyResults: true,
        testResults: '*/test-reports/.xml'
      )
      }
   } 
}
