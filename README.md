This project is about Containarized an application via Docker, and auto deploying it on kubernetes and auto provisiong the infrastructure via CloudFormation.

The jenkins perform the continous integration automatically by linting the docker file and testing the html code using the Publish HTML plugin.

## Building the application
To build your docker image from the source code without the pipeline: 
    docker build -t << your image tage >> .
    
## Implementing the infrastructure
### To implement your kubernetes cluster using Amazon elastic kubernetes service:
eksctl create cluster --name=<< your name >> --nodes=<< number of nodes you want >> --region=<< your intended aws region >>  --managed --node-type= << the node type you want to choose in your cluster nodes >>

## Deploying the application
To deploy the application after building your docker image (supposing the presence of the kubernetes cluster)
    kubectl apply -f deployment.yml
    
    
### List of files:
Dockerfile: The file to build the docker image
JenkinsFile: the file that jenkins auto detect and build pipeline
deployment.yml: the deployment file on kubernetes cluster for both the deployment and the service exposed on loadbalancer
aws.sh: bash script to autocreate the aws credentials.
