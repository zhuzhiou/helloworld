node {
    def maven3 = tool 'M3'
    checkout scm
    
    withEnv(["M3_HOME=$maven3"]) {
        echo "$M3_HOME"
    }

}