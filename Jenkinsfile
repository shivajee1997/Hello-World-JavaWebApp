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
        stage('Registry Push') {
            steps {
                dir("${workspace}") {
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'docker tag helloworldjavawebapp:latest 725482889936.dkr.ecr.us-east-1.amazonaws.com/helloworldjavawebapp:latest'
                        sh 'docker push 725482889936.dkr.ecr.us-east-1.amazonaws.com/helloworldjavawebapp:latest'
                        sh 'echo webhook'
                    }
                
                }
            }
        }
        stage('Eks Deploy') {
            steps {
                dir("${workspace}") {
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'aws eks update-kubeconfig --region us-east-1 --name first'
                        sh 'kubectl --version'
                    }
                
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
