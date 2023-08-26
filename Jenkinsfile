pipeline {
    agent any
    tools {
        maven 'Maven'
    }    
    stages {
        /*stage('Git Check Out') {
            steps {
           	gitCheckOut(
                    branch: "main",
                    url: "https://github.com/Barkha6/petclinicapp-demo.git"
                )
            }
        }*/ 
        
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        
   }
}
