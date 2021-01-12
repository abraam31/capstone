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

        stage('Testing html'){
            steps {
                    sh """ mkdir reports"""
                    script {
                        publishHTML([allowMissing: false, 
                        alwaysLinkToLastBuild: false, 
                        keepAll: false, 
                        reportDir: 'reports', 
                        reportFiles: 'index.html', 
                        reportName: 'HTML Report', 
                        reportTitles: ''])                 
                    }
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
        
        stage('getting kubernetes context '){
            steps {
                sh """ export PATH=$PATH:/usr/local/bin
                    /usr/local/bin/aws eks --region eu-west-1 update-kubeconfig --name capstone
                    kubectl get pods --all-namespaces
                    kubectl get nodes
                """
            }
        } 
        
        stage('Deploying on kubernetes '){
            steps {
                sh """ export PATH=$PATH:/usr/local/bin
                    kubectl delete -f deployment.yml
                    kubectl apply -f deployment.yml
                    kubectl get svc
                    kubectl get pods
                    kubectl describe svc my-service
                """
            }
        } 
    }

	post {
		always {
		    sh """ rm -rf ~/.aws """
			cleanWs ()
		}
	}
}