node {

    withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "GIT_COMMIT=${sh(returnStdout: true, script: 'git log -n 1 --pretty=format:%h').trim()}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {

        stage('DockerRun') {
            withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identityFile', passphraseVariable: '', usernameVariable: 'userName')]) {
                // 远程对象
                def remote = [name:'portal-h5', host:'172.16.27.203', user: userName, identityFile: identityFile, allowAnyHosts: true ]
                
                // 如果服务已启动调整服务
                //sshCommand remote: remote, command: "test \$(docker service ls --filter name=test-image | wc -l) -gt 1 && docker service update --force --image 172.16.27.205/test/test-image:2287b1e test-image"
                sshCommand remote: remote, command: "if [ \$(docker service ls --filter name=test-image | wc -l) -gt 1 ]; then docker service update --force --image 172.16.27.205/test/test-image:2287b1e test-image; fi"
                
                // 如果服务未跑起来创建服务
                sshCommand remote: remote, command: "test \$(docker service ls --filter name=test-image | wc -l) -eq 1 && \\"
                    + "docker service create \\"
                    + "--network portal \\"
                    + "--name test-image \\"
                    + "--publish published=8092,target=8080 \\"
                    + "--env spring.datasource.name=a \\"
                    + "--env spring.datasource.url=b \\"
                    + "172.16.27.205/test/test-image:2287b1e"
            }
        }
    }
}