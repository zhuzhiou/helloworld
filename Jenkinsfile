node {
    def maven3

    stage('Preparation') {
        checkout scm
        maven3 = tool 'M3'
    }
    
    stage('Build') {
        withEnv(["M3_HOME=$maven3"]) {
            echo "$M3_HOME/bin/mvn -DskipTests=true clean package"
        }
    }
}