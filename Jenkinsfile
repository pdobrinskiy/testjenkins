pipeline {
    agent { docker { image 'mjbobkov/pythonwork:1.0' } }
    stages {
        stage('build') {
            steps {
                sh 'python hello.py'
            }
        }
    }
}
