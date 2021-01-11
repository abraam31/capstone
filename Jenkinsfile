pipeline {
    agent any
    stages {
        stage('configuring aws'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'AWS-Credentials', passwordVariable: 'aws_secret_access_key', usernameVariable: 'aws_access_key_id')]) {
                    echo 'Generating AWS S3 Credentials...'
                    sh """ pwd 
                          ./aws.sh ${aws_access_key_id} ${aws_secret_access_key}
                          cat ~/.aws/credentials """
                }
            }
        }
        
        stage('docker build'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'docker_pass', usernameVariable: 'docker_user')]) {
                    echo 'logging to dockerhub '
                    sh """ docker login --username ${docker_users} --password ${docker_pass} """
                }
                script {
                    docker.withRegistry('https://hub.docker.com/', 'dockerhub') {
                          docker.build('capstone').push('latest')
                    }
                }
            }
        }        
    }
}