# This step triggers the Azure resource manager plugin download
terraform init

# Terraform needs service principal credentials for API access
az ad sp create-for-rbac --skip-assignment

# Take the result of create-for-rbac and update main.tf
#   appId    => service_principal.client_id
#   password => service_principal.client_secret
# Also paste in an SSH public key into ssh_key.key_data.

# Now create the k8s cluster; takes about 15 mins
terraform apply -auto-approve .

# Grab the credentials for kubectl
az aks get-credentials --resource-group moodle-rg --name moodle-aks

# Sanity check
kubectl get nodes

# Tunnel a connection to the k8s GUI on localhost:8001
# Also show portal.azure.com
az aks browse -g moodle-rg -n moodle-aks

# Now deploy Moodle
kubectl apply -f deploy.yaml

# This shows you when the public IP is available
kubectl get service moodle-app-svc --watch

kubectl describe service moodle-app-svc

kubectl logs -l app=moodle-app

kubectl get pods

kubectl exec -it $(kubectl get pods --no-headers -l app=moodle-app | awk '{print $1}') top

kubectl delete deployments --all

