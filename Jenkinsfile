node {

    

    withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "GIT_COMMIT=${sh(returnStdout: true, script: 'git log -n 1 --pretty=format:%h').trim()}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {
    
        
        
        stage('DockerBuild') {
            if (sh(script: 'docker image ls -q 172.16.27.205/test/test-image:aa', returnStdout: true).trim() == '') {
                echo "OK"
                //docker.withRegistry('https://172.16.27.205/', 'harborUser') {
                //    docker.build("172.16.27.205/test/test-image:${env.GIT_COMMIT}").push()
                //}
            }
        }

        
    }
}