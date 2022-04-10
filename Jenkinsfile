
pipeline {
  agent { label 'terraform' }
  stages {
     stage('Build') {
           agent { kubernetes }
            steps {
                sh 'python hello.py'
            }
        }
    
     stage('Plan') {
           agent { kubernetes }
            steps {
                sh 'terraform version'
                sh 'terraform init'
                sh 'terraform plan -out=plan.tfplan -input=false'
                sh 'terraform show -no-color plan.tfplan > plan.txt'
                sh 'terraform show -json plan.tfplan > plan.json'

            }
        }
    
    stage('push_to_Artifactory') {
      steps {
        script {
             def server = Artifactory.server 'aaz'

def uploadSpec = 
"""
{
"files": [
     {
        "pattern": "*.tf",
        "target": "jfrogrepo"
      }

  ]
}"""
         server.upload(uploadSpec) 
    }
    }
  }
}
}
