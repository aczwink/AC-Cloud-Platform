cd infrastructure
terraform apply -auto-approve
export STORAGE_ACCOUNT_KEY=$(terraform output -raw storage_account_key)
export STORAGE_ACCOUNT_NAME=$(terraform output -raw storage_account_name)
cd ..

az aks get-credentials --resource-group prd-rg-aksaccp --name prd-aks-aksaccp --overwrite-existing



sed \
  -e "s|<storage-account-key>|$STORAGE_ACCOUNT_KEY|g" \
  -e "s|<storage-account-name>|$STORAGE_ACCOUNT_NAME|g" \
  k8s/storage-account-secret.yml \
| kubectl apply -f -

kubectl apply -f arabicmusicencyclopedia/persistent-volume.yml
kubectl apply -f arabicmusicencyclopedia/namespace.yml
kubectl apply -f arabicmusicencyclopedia/persistent-volume-claim.yml
kubectl apply -f arabicmusicencyclopedia/backend-deployment.yml
kubectl apply -f arabicmusicencyclopedia/backend-service.yml