https://kubernetes.io/docs/tasks/tools/install-kubectl/

```
alias k=kubectl
complete -F __start_kubectl k
```

```
kubectl api-resources

kubectl logs --selector app=my-app-web --follow
--tail 3 --follow --max-log-requests 999999

# see apiserver request:
kubectl get pods -v9


iptables -t nat -nL
iptables -t nat -nL KUBE-SVC-ASDFADF

kubectl create role blue-can-view --role=view --user=default
kubectl create rolebinding blue-can-view --role=view --user=default

kubectl create role blue-can-view --clusterrole=view --user=default
kubectl create rolebinding blue-can-view --clusterrole=view --serviceaccount=default
kubectl create rolebinding

kubectl auth can-i get pods
kubectl auth can-i get pods --as system:serviceaccount:blue:default

# jsonpath:
kubectl get cm/proxysql -o jsonpath="{.data.proxysql\.cnf\.tmpl}"
```

# Install

## Ubuntu

```
sudo apt-get update
sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install kubectl
```

## microk8s

```
sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
sudo snap alias microk8s.kubectl k
sudo usermod -a -G microk8s your_username
```

## kubectl rollout

```
kubectl rollout history deployment/web
kubectl rollout undo deployment/web

# roll back to a specific version:
kubectl rollout undo deployment/web --to-revision=12

# wait for rollout to finish:
kubectl rollout status -w deployment/web
```

## Clean up Evicted pods

```
kubectl delete pods --field-selector=status.phase=Failed -n default
```
