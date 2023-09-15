pipeline {
    agent any
    
    environment {
        registryCredential = 'ecr:ap-south-1:awscreds'
        appRegistry = '485490367164.dkr.ecr.ap-south-1.amazonaws.com/demo'
        awsRegistry = "https://485490367164.dkr.ecr.ap-south-1.amazonaws.com"
        cluster = "Stagging-Environment"
        service = "demo-app"
    }

    stages {
        stage('Build App Image') {
            steps {
                script {
                    dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./Dockerfiles/App/")
                }
            }
        }
        
        stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( awsRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
        }
        stage('Deploy to ECS staging') {
            steps {
                withAWS(credentials: 'awscreds', region: 'ap-south-1') {
                    sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
                }
            }
        }
    }
}
