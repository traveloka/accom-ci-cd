#!/usr/bin/env bash

set -e

mkdir -p ~/.ssh
SSH_PRIVATE_KEY="/tvlk-secret/codebuild/github-ssh-private-key"
aws ssm get-parameters --name ${SSH_PRIVATE_KEY} --with-decryption --query "Parameters[*].{Value:Value}" --region ap-southeast-1 --output text > ~/.ssh/id_rsa || true
if [ -s ~/.ssh/id_rsa ]; then
    chmod 400 ~/.ssh/id_rsa
    eval $(ssh-agent -s)
    ssh-add /root/.ssh/id_rsa
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    echo "Github ssh private key is set"
fi