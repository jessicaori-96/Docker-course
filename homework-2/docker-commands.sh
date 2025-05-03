#!/bin/bash

# Exercise 1
# 1. List all Docker networks.
docker network list
# 2. Inspect the default bridge network.
docker network inspect bridge
# 3. Create a new bridge user-defined network.
docker network create dockernet
# 4. Run a container attached to it and inspect its IP.
docker run -d --name webserver5 --network dockernet nginx
docker container inspect webserver5
#o
docker exec -it webserver5 bash
apt update
apt install iproute2 -y
ip add
exit

# Exercise 2
# 1. Run two Nginx containers which have to be connected to that user-defined network created in Exercise 1.
docker run -d --name webserver1 --network dockernet nginx
docker run -d --name webserver2 --network dockernet nginx
# 2. Use ping within both containers to test communication each other by container name
docker exec -it webserver1 bash
apt update
apt install iproute2 -y
apt install iputils-ping
ping webserver2
exit

docker exec -it webserver2 bash
apt update
apt install iproute2 -y
apt install iputils-ping
ping webserver1
exit

# Exercise 3
# 1. Create a Docker volume: mydata.
docker volume create mydata
# 2. Run a container using the volume.
docker run -dit --name my-first-container -v mydata:/data ubuntu
# 3. Write a file inside /data from the container, then:
#    1. Stop the container.
#    2. Relaunch to verify persistence.
docker exec -it my-first-container bash
echo "Hi everyone" > /data/test3.txt
exit
docker stop my-first-container
docker ps -a
docker start my-first-container
docker exec -it my-first-container cat /data/test3.txt

# Exercise 4
# 1. Create a directory on your host.
mkdir mydirectory
# 2. Run a container with a bind mount.
docker run -dit --name mycontainer -v ~/mydirectory:/mnt ubuntu
# 3. Create a file in /mnt from the container and check the host.
docker exec -it mycontainer bash
touch /mnt/test.txt
exit
cd mydirectory/
ls
cd ..

# Exercise 5
# 1. Create a file in a named volume.
docker run -dit --name my-second-container -v mydata:/data ubuntu
docker exec -it my-second-container bash
touch data/test.txt
exit
# 2. Create a file using a bind mount.
docker run -dit --name my-third-container -v ~/mydirectory:/mnt ubuntu
docker exec -it my-third-container bash
touch /mnt/test2.txt
exit
# 3. Observe where data is stored on the host with docker volume inspect and ls .
cd mydirectory
ls
docker inspect mydata
sudo ls /var/lib/docker/volumes/mydata/_data
cd ..

# Exercise 6
# 1. Run an Ubuntu container with the necessary options to enable Docker in Docker (DinD).
docker run -dit --name mydind -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker ubuntu
# 2. Exec into the container and run docker version.
docker exec -it mydind bash
docker version
exit

# Exercise 7
# 1. Run a container with memory and CPU limits:
#     1. Memory = 256m
#     2. CPU = 0.5
docker run -dit --name my-fourth-container --memory=256m ubuntu
docker run -dit --name my-fifth-container --cpus="0.5" ubuntu
docker run -dit --name my-sixth-container --memory=256m --cpus="0.5" ubuntu
# 2. Check resource usage stats .
docker stats
# 3. Check disk usage (docker system).
docker system df

# Exercise 8
# 1. Run a container with policy --restart on-failure .
docker run -dit --name my-seventh-container --restart on-failure ubuntu
# 2. Kill the container and observe how it restarts
docker kill my-seventh-container
# 3. Try with the policy --restart unless-stopped
docker run -dit --name my-eighth-container --restart unless-stopped ubuntu
# 4. Reboot the system and see what happens.
sudo reboot
ssh -i k8s-instance-14 ubuntu@10.26.32.189

# Exercise 9
# 1. Create a network dbnet
docker network create dbnet
# 2. Create a volume dbdata .
docker volume create dbdata
# 3. Run a MariaDB container with the following requirements:
#     1. Attached to volume dbdata .
#     2. Attached to network dbnet .
#     3. Do NOT expose ANY port.
docker run -dit --name mydb --network dbnet -v dbdata:/home -e MARIADB_ROOT_PASSWORD=root -e MARIADB_DATABASE=mydb -e MARIADB_USER=jess -e MARIADB_PASSWORD=root mariadb

# Exercise 10
# Run a PHPMyAdmin container with the following requirements:
# 1. Attached to network dbnet (created in Exercise 9).
# 2. Use a bind mount to persist the web app configuration.
# 3. Linked to the previous MariaDB container (created in Exercise 9)
# 4. Open a browser to display the PHPMyAdmin Login Form.
# 5. Login with the DB credentials
docker run -dit --name myphp --network dbnet -v ~/mydirectory:/etc/phpmyadmin/config.user.inc.php -e PMA_HOST=mydb -e PMA_PORT=3306 -p 8080:80 phpmyadmin/phpmyadmin