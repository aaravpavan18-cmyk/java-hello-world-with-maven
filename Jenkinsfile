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
                sh 'mvn clean test'
            }
        }

       

        

       
        stage('SonarQube Static Analysis') {
            steps {
                withSonarQubeEnv('Sonarqube') { 
                    // Tell SonarQube exactly where to find the JaCoCo XML report
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar'
                        
                    
                }
            }
        }

        //stage('Publish Coverage to Jenkins') {
            //steps {
                // This displays an interactive Code Coverage report chart directly on the Jenkins Build UI
                // Note: Requires the "JaCoCo Plugin" to be installed on your Jenkins server
                jacoco(
                    //execPattern: 'target/*.exec',
                    //classPattern: 'target/classes',
                    //sourcePattern: 'src/main/java',
                    //exclusionPattern: '**/*Test*.class'
                //)
            //}
        //}

       

        stage('Package Artifact') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Archive Local Copy') {
            steps {
                // Copies any jar or war generated in the target directory back to the local Jenkins controller storage
                archiveArtifacts artifacts: 'target/*.?ar', allowEmptyArchive: false, fingerprint: true
                
                echo "Artifact successfully copied out of the container and saved on the Jenkins host!"
            }
        }

        stage('Build & Tag Docker Image') {
            steps {
                // This builds your Docker image using the Dockerfile we created earlier
                sh 'docker build -t hello-maven-app:latest .'
                echo "Docker image built successfully from the generated JAR file!"
            }
        }            
    }
}
