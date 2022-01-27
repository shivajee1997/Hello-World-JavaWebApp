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
                sh 'docker build -t hello-world-javawebapp:latest'
                }
            }
        }
        stage('Registry') {
            steps {
                dir("${workspace}") {
                sh 'docker image tag hello-world-javawebapp:latest public.ecr.aws/n3z7k8z4/venkata_first/hello-world-javawebapp:latest'
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
