https://kubernetes.io/docs/tasks/tools/install-kubectl/

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
