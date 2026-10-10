pipeline {
    agent {
        label 'maven-docker'
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
            }
        }

        stage('Archive Local Copy') {
            steps {
                archiveArtifacts artifacts: 'target/*.?ar', allowEmptyArchive: false, fingerprint: true
                echo "Artifact successfully copied out of the container and saved on the Jenkins host!"
            }
        }

        stage('Publish to Nexus via Plugin') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus2',
                    protocol: 'http',
                    nexusUrl: '10.253.41.229:8081/repository',
                    repository: 'maven-builds',
                    credentialsId: 'nexus',
                    groupId: 'org.springframework',
                    version: '0.2.0',
                    artifacts: [
                        [
                            artifactId: 'jb-hello-world-maven',
                            classifier: '',
                            file: 'target/jb-hello-world-maven-0.2.0.jar',
                            type: 'jar'
                        ]
                    ]
                )
                echo "Artifact successfully published to Nexus via Jenkins Plugin!"
            }
        }

    }
}
