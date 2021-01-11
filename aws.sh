#!/bin/bash
cd ~
pwd 
AWS_ACCESS_KEY_ID_VALUE=$1
AWS_SECRET_ACCESS_KEY_VALUE=$2

if [[ ! -d .aws ]]; then
    mkdir .aws
    echo "created!"
else 
    echo "already exist!"
fi

if [[ ! -f .aws/credentials ]]; then
    cat > .aws/credentials <<EOF
    [default]
    aws_access_key_id = $AWS_ACCESS_KEY_ID_VALUE
    aws_secret_access_key = $AWS_SECRET_ACCESS_KEY_VALUE
EOF
else 
    echo "credentials already here"
fi 