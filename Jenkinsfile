pipeline {
    agent {
        label 'maven-docker'
    }

    stages {
        stage('Install Git Dynamically') {
            steps {
                // Determine container type and install git before SCM checkout runs
                sh '''
                    if [ -f /etc/alpine-release ]; then
                        echo "Detected Alpine Linux. Installing git..."
                        apk add --no-cache git
                    elif [ -f /etc/debian_version ] || [ -f /etc/lsb-release ]; then
                        echo "Detected Debian/Ubuntu Linux. Installing git..."
                        apt-get update && apt-get install -y git
                    elif [ -f /etc/redhat-release ]; then
                        echo "Detected RHEL/CentOS/Fedora Linux. Installing git..."
                        yum install -y git
                    else
                        echo "Unknown Linux distribution. Attempting generic install..."
                        apk add --no-cache git || apt-get update && apt-get install -y git || yum install -y git
                    fi
                    git --version
                '''
            }
        }
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