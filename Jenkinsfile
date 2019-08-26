node {

    withEnv(["JAVA_HOME=${tool 'jdk1.8.0_221'}", "GIT_COMMIT=${sh(returnStdout: true, script: 'git log -n 1 --pretty=format:%h').trim()}", "PATH+M3_HOME=${tool 'M3'}/bin:${env.JAVA_HOME}/bin"]) {

        stage('DockerRun') {
            writeFile file: 'dockerRun.sh', text: """docker ps -a -q --filter name=test-image;if test -n "$containers"; then docker container stop $containers; docker container rm $containers; fi
""", encoding: 'UTF-8';
            sh "ssh root@172.16.27.203 'bash -x -s' < dockerRun.sh"
        }
    }
}