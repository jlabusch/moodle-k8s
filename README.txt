Speaker notes/prompts for brown bag demo
--------------------------------------------

terraform init                              # triggers the Azure resource manager plugin download

az ad sp create-for-rbac --skip-assignment  # create service principal credentials for API access

# Take the result of create-for-rbac and update main.tf
#   appId    => service_principal.client_id
#   password => service_principal.client_secret
# Also paste in an SSH public key into ssh_key.key_data.

terraform apply -auto-approve .             # create the k8s cluster; takes about 15 mins

# Grab the credentials for kubectl
az aks get-credentials --resource-group moodle-rg --name moodle-aks


kubectl get nodes                           # Sanity check that we have VMs

# Tunnel a connection to the k8s GUI on localhost:8001
# Also show portal.azure.com
az aks browse -g moodle-rg -n moodle-aks

kubectl apply -f deploy.yaml                # deploy Moodle and DB

kubectl get service moodle-app-svc --watch  # shows when the public IP is available

kubectl describe service moodle-app-svc     # show more detail

kubectl logs -l app=moodle-app              # show filtering by label

kubectl exec -it $(kubectl get pods --no-headers -l app=moodle-app | awk '{print $1}') top

kubectl delete deployments --all

