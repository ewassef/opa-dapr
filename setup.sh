#install kind on your local machine 

#install kind, exposing 80 and 443 ports for ingress
kind create cluster --config ./kind.yaml

#install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml

#install dapr
helm repo add dapr https://dapr.github.io/helm-charts/
helm repo update
helm upgrade --install dapr dapr/dapr --namespace dapr-system --create-namespace --version=1.6.0 --wait


#install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install nginx ingress-nginx/ingress-nginx -f .\nginx-values.yaml -n ingress-nginx --create-namespace --version 4.0.6



kubectl apply -f ./configure-dapr.yaml
kubectl apply -f ./configure-app.yaml

#This call should fail based on the policy. 
curl http://backend.dev-k8s.cloud/
