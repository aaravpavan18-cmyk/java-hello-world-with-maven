pipeline {
    agent {
        label 'maven-docker'
    }

    //options {
        //skipDefaultCheckout()
    //}

    stages {

        stage('Checkout Source') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']], 
                    extensions: [], 
                    userRemoteConfigs: [[
                        credentialsId: 'gitpat', 
                        url: 'https://github.com/aaravpavan18-cmyk/java-hello-world-with-maven.git'
                    ]]
                ])
            }
        }

        stage('Maven Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Execute Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package Artifact') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('SonarQube Static Analysis') {
            steps {
                withSonarQubeEnv('Sonarqube') { 
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar'
                }
            }
        }

        stage('Archive Local Copy') {
            steps {
                // Copies any jar or war generated in the target directory back to the local Jenkins controller storage
                archiveArtifacts artifacts: 'target/*.?ar', allowEmptyArchive: false, fingerprint: true
                
                echo "Artifact successfully copied out of the container and saved on the Jenkins host!"
            }
        }
    }
}
