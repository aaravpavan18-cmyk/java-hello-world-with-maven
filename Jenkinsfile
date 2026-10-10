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

        stage('Publish to Nexus') {
            steps {
                // We use Maven's command line options to pass credentials dynamically.
                // This injects the variables securely and overrides the server mapping on the fly.
                sh '''
                    mvn deploy -DskipTests \
                    -Dusername=${NEXUS_CREDS_USR} \
                    -Dpassword=${NEXUS_CREDS_PSW}
                '''
                echo "Artifact successfully pushed to Nexus Repository Server!"
            }
        }
    }
}
