node {
    def maven3

    stage('Preparation') {
        checkout scm
        maven3 = tool 'M3'
    }
    
    stage('Build') {
        withEnv(["M3_HOME=$maven3"]) {
            sh "$M3_HOME/bin/mvn -DskipTests=true clean package"
        }
    }
    
    stage('DockerBuild') {
        docker.build("test-image:${env.BUILD_ID}")
    }
}