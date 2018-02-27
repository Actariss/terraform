#!/bin/bash

sudo apt-get update

sudo apt-get install -y jq

sudo apt-get install unzip

sudo apt-get update

TF_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M ".current_version")
wget -O terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
wget -O terraform.sha256 https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS
wget -O terraform.sha256.sig https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS.sig
curl -s https://keybase.io/hashicorp/pgp_keys.asc | gpg --import
gpg --verify terraform.sha256.sig terraform.sha256
echo $(grep -Po "[[:xdigit:]]{64}(?=\s+terraform_${TF_VERSION}_linux_amd64.zip)" terraform.sha256) terraform.zip | sha256sum -c
unzip terraform.zip
mv terraform /usr/local/bin
rm -f terraform terraform.zip terraform.sha256 terraform.sha256.sig
unset TF_VERSION

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893

sudo apt-get install apt-transport-https

sudo apt-get update && sudo apt-get install azure-cli

sudo apt-get update 

