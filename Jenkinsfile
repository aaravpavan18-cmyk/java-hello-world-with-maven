pipeline {
    agent {
        label 'maven-agent'
    }


    stages {
        stage('checkout') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'gitpat', url: 'https://github.com/aaravpavan18-cmyk/java-hello-world-with-maven.git']]])
            }
        }
        stage('build') {
            steps{
               bat 'mvn package'
            }
        }
    }
}