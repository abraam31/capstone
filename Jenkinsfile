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

        stage('linting'){
            steps {
                // Ignoring the hadolint warning of not tagging Docker image with word latest
                    sh """ hadolint --ignore DL3007 Dockerfile"""
                }
            }
        
        stage('docker build'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'docker_pass', usernameVariable: 'docker_user')]) {
                    echo 'logging to dockerhub '
                    sh """ docker login --username ${docker_user} --password ${docker_pass} """
                }
                script {
                    docker.withRegistry('', 'dockerhub') {
                          docker.build('abraam31/capstone')
                    }
                }
            }
        } 
        
        stage('getting the kubeconfig '){
            steps {
                sh """ aws eks --region eu-west-1 update-kubeconfig --name capstone
                    kubectl get pods --all-namespaces
                    kubectl get nodes
                """
            }
        } 
    }
}