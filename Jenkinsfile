pipeline {
    agent {
        label 'maven-docker'
    }
    // Define the managed Git tool version configured in Jenkins Global Tool Configuration
    tools {
        // 'Default' should match the exact name of your Git installation in Jenkins
        git 'Default' 
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