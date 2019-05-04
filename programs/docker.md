Docker for Mac:
- https://download.docker.com/mac/stable/Docker.dmg
- https://download.docker.com/mac/edge/Docker.dmg

Clean images:
```
docker kill $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images | grep -v 'ubuntu\|redis' | awk {'print $3'})
docker rmi $(docker images -aq)
```

Allow ubuntu user to use docker:
```
sudo usermod -aG docker ubuntu
# then reboot
```

Enable experimental features:
```
$ sudo vim /etc/docker/daemon.json
{"experimental": true}
$ sudo systemctl restart docker
```
