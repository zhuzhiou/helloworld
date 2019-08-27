node {

    withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "GIT_COMMIT=${sh(returnStdout: true, script: 'git log -n 1 --pretty=format:%h').trim()}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {

        stage('DockerRun') {
            withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identityFile', passphraseVariable: '', usernameVariable: 'userName')]) {
                def remote = [name:'portal-h5', host:'172.16.27.203', user: userName, identityFile: identityFile, allowAnyHosts: true ]
                sshCommand remote: remote, command: "test \$(docker service ls --filter name=test-image | wc -l) -eq 1 && docker service create --network portal --name test-image --publish published=8092,target=8080 172.16.27.205/test/test-image:2287b1e"
                sshCommand remote: remote, command: "test \$(docker service ls --filter name=test-image | wc -l) -gt 1 && docker service update --force --image nginx:1.17.3 172.16.27.205/test/test-image:2287b1e"
            }
        }
    }
}