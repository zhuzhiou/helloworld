node {

    stage('Preparation') {
        checkout scm
    }
    
    stage('Build') {
        withEnv(["M3_HOME=${tool 'M3'}"]) {
            sh "${M3_HOME}/bin/mvn -DskipTests=true clean package"
        }
    }
    
    stage('DockerBuild') {
        docker.withRegistry('https://172.16.27.205/', 'HARBOR_USER') {
            docker.build("test/test-image:${env.BUILD_ID}").push()
        }
    }
    
    
}