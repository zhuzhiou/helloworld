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
    
    def remote = [:]
    remote.name = 'h5-server'
    remote.host = '172.16.27.203'
    remote.allowAnyHost = true
    
    withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identityFile', passphraseVariable: 'passphrase', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.identityFile = identityFile
        stage('DockerRun') {
            sshCommand remote: remote, command: 'mkdir /opt/portal/helloworld'
            sshPut remote: remote, from: 'docker-compose.yaml', into: '/opt/portal/helloworld'
            sshCommand remote: remote, command: 'docker-compose -f /opt/portal/helloworld/docker-compose.yaml up -d'
        }
    }
}