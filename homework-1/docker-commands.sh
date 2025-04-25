#!/bin/bash

# Exercise 1
# 1. Install Docker Engine using the official Docker APT repository
ssh -i k8s-instance-14 ubuntu@10.26.32.189
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# 2. Enable and start the Docker service.
sudo usermod -aG docker $USER
exit
ssh -i k8s-instance-14 ubuntu@10.26.32.189
# 3. Print the info of the Docker Client and Server.
sudo docker info

# Exercise 2
# 1. Search for the official repos of Ubuntu, Alpine, Nginx.
docker search ubuntu --filter is-official=true
docker search alpine --filter is-official=true
docker search nginx --filter is-official=true
# 2. Run an Nginx container using the image from the official repo.
docker pull nginx
docker run --name mynginx -d nginx

# Exercise 3
# 1. Check Docker daemon status
sudo systemctl status docker
# 2. Stop the Docker daemon
sudo systemctl stop docker.service docker.socket
# 3. Run a container while it’s stopped.
docker run --name my-third-nginx -d nginx
# 4. Restart the Docker daemon and run a container again.
sudo systemctl restart docker
docker run --name my-third-nginx -d nginx

# Exercise 4
# 1. Run an Ubuntu container interactively.
docker run -it --name my-ubuntu ubuntu:latest /bin/bash
# 2. Use apt update && apt install curl inside the container.
apt update && apt install curl
# 3. Exit the container.
exit

# Exercise 5
# 1. List running containers:
docker container list
docker ps
# 2. List all containers (including exited)
docker container list -a
docker ps -a

# Exercise 6
# 1. Run a container in the background
docker run --name my-nginx -d nginx 
# 2. Then Pause it
docker pause my-nginx
# 3. Unpause it:
docker unpause my-nginx
# 4. Stop it
docker stop my-nginx
# 5. Restart it
docker restart my-nginx
# 6. Kill it
docker kill my-nginx

# Exercise 7
# Remove a running container.
docker run --name my-second-nginx -d nginx
docker rm -f my-second-nginx

# Exercise 8
# 1. Pull the alpine and ubuntu images.
docker pull alpine
docker pull ubuntu
# 2. List all the container images in your Docker Host.
docker images
docker image list

# Exercise 9
# 1. Run alpine and execute echo "hello from alpine"
docker run alpine:latest echo "hello from alpine"
# 2. Run busybox and execute uname -a
docker run busybox uname -a
# 3. List all the container
docker ps -a

# Exercise 10
# 1. Remove all stopped containers.
docker container prune -f
# 2. Remove unused images.
docker image prune -a -f
# 3. Inspect Docker disk usage
docker system df