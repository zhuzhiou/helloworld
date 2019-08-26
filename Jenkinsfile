node {

    stage('Preparation') {
        checkout scm
    }
    
    stage('Build') {
        withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {
            sh "mvn -DskipTests=true clean package"
        }
    }
    
    stage('DockerBuild') {
        docker.withRegistry('https://172.16.27.205/', 'harborUser') {
            docker.build("test/test-image:${env.BUILD_ID}").push()
        }
    }
    
    stage('DockerRun') {
        withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identityFile', passphraseVariable: '', usernameVariable: 'userName')]) {
            def remote = [:]
            remote.name = 'portal-h5'
            remote.host = '172.16.27.203'
            remote.allowAnyHosts = true
            remote.user = userName
            remote.identityFile = identityFile
        
            //sshCommand remote: remote, command: 'mkdir -p /opt/portal/helloworld'
            //sshCommand remote: remote, command: 'existContainers=$(docker ps -a -q --filter name=test-image);if test -n "$existContainers"; then docker container stop $existContainers; docker container rm $existContainers; fi'
            //sshCommand remote: remote, command: "docker run -d -p 8092:8080 --name test-image 172.16.27.205/test/test-image:${env.BUILD_ID}"
        }
    }
}