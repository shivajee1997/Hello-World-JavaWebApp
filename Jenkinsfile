pipeline {
    agent any
    tools {
        maven "Maven"
        jdk "JDK"
    }
    environment { 
       NAME = "helloworldjavawebapp"
       VERSION = "${env.BUILD_ID}"
       IMAGE = "${NAME}:${VERSION}"
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
                
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 725482889936.dkr.ecr.us-east-1.amazonaws.com'
                        sh 'docker tag helloworldjavawebapp:latest 725482889936.dkr.ecr.us-east-1.amazonaws.com/${IMAGE}'
                        sh 'docker push 725482889936.dkr.ecr.us-east-1.amazonaws.com/${IMAGE}'
                    }
                
                
            }
        }
        stage('Eks Deploy') {
            steps {
                
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'aws eks update-kubeconfig --region us-east-1 --name First'
                        sh 'echo 7725482889936.dkr.ecr.us-east-1.amazonaws.com/${IMAGE}'
                        sh 'kubectl set image deployment.v1.apps/first-java-deployment java=725482889936.dkr.ecr.us-east-1.amazonaws.com/${IMAGE} -n first-java'
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
