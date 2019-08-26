node {
    
    stage('Preparation') {
        checkout scm
    }
    
    withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "GIT_COMMIT=${sh(returnStdout: true, script: 'git log -n 1 --pretty=format:%h').trim()}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {

        stage('Build') {
            sh "mvn -DskipTests=true clean package"
        }
    
        stage('DockerBuild') {
            docker.withRegistry('https://172.16.27.205/', 'harborUser') {
                docker.build("172.16.27.205/test/test-image:${env.GIT_COMMIT}").push()
            }
        }
    
        stage('DockerRun') {
            sh 'ssh 172.16.27.203'
        }
    }
}