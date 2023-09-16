pipeline {
    agent any
    
    environment {
        appRegistry = '485490367164.dkr.ecr.ap-south-1.amazonaws.com/demo'
        awsRegistry = "https://485490367164.dkr.ecr.ap-south-1.amazonaws.com"
        cluster = "demo"
        service = "demo-app"
    }

    stages {
        stage('ECR login') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 485490367164.dkr.ecr.ap-south-1.amazonaws.com'
                }
            }
        }
        stage('Build App Image') {
            steps {
                script {
                   sh 'docker push 485490367164.dkr.ecr.ap-south-1.amazonaws.com/demo:35'
                }
            }
        }
        
        stage('Upload App Image') {
          steps{
            script {
              sh 'docker push 485490367164.dkr.ecr.ap-south-1.amazonaws.com/demo:34'
          }
        }
        }
        stage('Deploy to ECS') {
            steps {
                withAWS(credentials: 'awscreds', region: 'ap-south-1') {
                    sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
                }
            }
        }
    }
}
