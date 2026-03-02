#!/bin/bash

appId=$(az ad app create --display-name github_actions_amir_czwink --query appId --output tsv | tr -d '\r')
az ad sp create --id $appId
az ad app federated-credential create --id $appId --parameters github-credential.json
az ad app federated-credential create --id $appId --parameters github-credential-dev.json