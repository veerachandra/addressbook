pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "MAVEN Installed in EC2"
    }

    stages {
        stage('Compile') {
            agent {label "jenkins-slave1"}
            steps {              
              script{
                     echo "Veera mvn COMPILING"
                     sh "mvn compile"
              }             
            }
            
        }
        stage('Test') {
            agent any
            steps {           
              script{
                   echo "Veera mvn RUNNING THE TC"
                   sh "mvn test"
                }              
             
            }            
        
        post{
            always{
                junit 'target/surefire-reports/*.xml'
            }
        }
        }
        stage('Package') {
            agent any
            steps {              

                script{
                    sshagent(['slave-2']) {
                    echo "veera Copy the server-script.sh file to 172.31.38.62 in AWS for installing basic libraries mentioned in this file"
                    sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.38.62:/home/ec2-user"
                    echo "veera ssh -o StrictHostKeyChecking=no ec2-user@172.31.38.62 'bash server-script.sh' starts executing the file to 172.31.38.62 in AWS for installing basic libraries mentioned in this file"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.38.62 'bash server-script.sh'"
                   echo "veera Creating the mvn package for the git project for the new slave instance 172.31.38.62 in AWS "
                   sh "mvn package"
                }             
                }
            }            
        }

    }
}
