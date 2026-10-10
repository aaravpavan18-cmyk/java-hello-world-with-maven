pipeline {
    agent {
        label 'maven-docker'
    }

    // 🌟 ADD THIS BLOCK TO YOUR UPSTREAM BUILD JOB 🌟
    options {
        // Replace 'upload-nexus-job' with the EXACT name of your current upload job
        copyArtifactPermission('upload-maven-artifacts') 
    }

    environment {
        // Securely bind your Nexus credentials from the Jenkins dashboard
        // 'nexus-credentials-id' must match the exact ID you created in the Jenkins UI
        NEXUS_CREDS = credentials('nexus')
    }

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
                sh 'mvn clean test'
            }
        }

        //stage('SonarQube Static Analysis') {
            //steps {
                //withSonarQubeEnv('Sonarqube') { 
                    //sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar'
                //}
            //}
        //}

        stage('Package Artifact') {
            steps {
                sh 'mvn package -DskipTests'
                sh "mv target/jb-hello-world-maven-0.2.0.jar target/jb-hello-world-maven-${env.BUILD_NUMBER}.jar"
                //sh 'mvn clean package -Dmaven.repo.local=.m2/repository'
            }
        }

        stage('Archive Local Copy') {
            steps {
                //archiveArtifacts artifacts: 'target/*.?ar', allowEmptyArchive: false, fingerprint: true
                archiveArtifacts artifacts: "target/jb-hello-world-maven-${env.BUILD_NUMBER}.jar", allowEmptyArchive: false
                echo "Artifact successfully copied out of the container and saved on the Jenkins host!"
            }
        }

        stage('Trigger Upload') {
            steps {
                // Trigger the downstream job and pass the current build number
                build job: 'upload-maven-artifacts', parameters: [
                    string(name: 'UPSTREAM_BUILD_NUMBER', value: "${BUILD_NUMBER}")
                ]
            }
        }

    }
}
