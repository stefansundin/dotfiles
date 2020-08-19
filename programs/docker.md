Docker for Mac:
- https://download.docker.com/mac/stable/Docker.dmg
- https://download.docker.com/mac/edge/Docker.dmg

credHelpers:
- https://github.com/awslabs/amazon-ecr-credential-helper

```
{
	"credHelpers": {
		"aws_account_id.dkr.ecr.region.amazonaws.com": "ecr-login"
	}
}
```

Clean up stuff:
```
docker system prune
```

Clean up orphaned volumes:
```
docker volume rm $(docker volume ls -qf dangling=true)
```

Clean up images:
```
docker kill $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images | tail -n +2 | grep -v 'ubuntu\|redis' | awk {'print $3'} | uniq)
docker rmi -f $(docker images -aq)
docker volume prune
```

Allow ubuntu user to use docker:
```
# if the group does not exist, create it: (this is the case for snap)
sudo groupadd docker

# add user to group:
sudo usermod -aG docker ubuntu

# discover the new group:
newgrp docker

# restart daemon:
sudo systemctl restart docker
sudo snap restart docker

# try without sudo:
docker ps

# if things still don't work, log out and back in.
# as a last resort, try rebooting
```

Enable experimental features:
```
$ sudo vim /etc/docker/daemon.json
{"experimental": true}
$ sudo systemctl restart docker

# using snap:
$ sudo vim /var/snap/docker/current/config/daemon.json
$ sudo snap restart docker
```
