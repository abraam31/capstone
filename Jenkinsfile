pipeline {
    agent any
    stages {
        stage('configuring aws'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'AWS-Credentials', passwordVariable: 'aws_secret_access_key', usernameVariable: 'aws_access_key_id')]) {
                    echo 'Generating AWS S3 Credentials...'
                    pwd 
                    sh """./aws.sh ${aws_access_key_id} ${aws_secret_access_key}"""
                    cat .aws/credentials
                }
            }
        }
    }
}