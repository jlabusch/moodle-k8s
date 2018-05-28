az group create --name k8s-moodle-test --location westeurope

az aks create --resource-group k8s-moodle-test --name k8s-moodle-cluster --node-count 1 --generate-ssh-keys

az aks get-credentials --resource-group k8s-moodle-test --name k8s-moodle-cluster

az aks browse -g k8s-moodle-test -n k8s-moodle-cluster

kubectl apply -f k8s-deployment.yaml

kubectl get service moodle-app-svc --watch

kubectl logs -l app=moodle-app

kubectl get pods

kubectl exec -it moodle-app-deployment-678bb8578c-r6zpn bash


