pipeline {
  agent any
  stages {
    stage('Linter.............') {
      agent any
      steps {
        sh 'yamllint -s .'
      }
    }
     stage('Build') {
           agent { docker { image 'mjbobkov/pythonwork:1.0' } }
            steps {
                sh 'python hello.py'
            }
        }
    
     stage('Plan') {
           agent { docker { image 'hashicorp/terraform:latest' 
                           args "-it --entrypoint=''"
                          } }
            steps {
                sh 'terraform version'
                sh 'terraform init'
                sh 'terraform plan'
            }
        }
  }
}
