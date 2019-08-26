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
    remote.name = 'portal-h5'
    remote.host = '172.16.27.203'
    remote.allowAnyHosts = true
    
    withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identityFile', passphraseVariable: '', usernameVariable: 'userName')]) {
        echo "${userName} - ${passphrase}"
        remote.user = userName
        remote.identityFile = identityFile
        //remote.passphrase = passphrase
        stage('DockerRun') {
            sshCommand remote: remote, command: 'mkdir /opt/portal/helloworld'
            sshPut remote: remote, from: 'docker-compose.yaml', into: '/opt/portal/helloworld'
            sshCommand remote: remote, command: 'docker-compose -f /opt/portal/helloworld/docker-compose.yaml up -d'
        }
    }
}