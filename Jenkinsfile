pipeline {
    agent {
        docker 'maven:3.6.1-jdk-8'
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}