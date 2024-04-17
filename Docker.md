# Docker Mastery: with Kubernetes +Swarm from a Docker Captain

[Udemy Course Link](https://www.udemy.com/course/docker-mastery/learn/lecture/6489842#overview)

## What you will learn

- How to use Docker, Compose and Kubernetes on your machine for better software building and testing.
- Learn Docker and Kubernetes official tools from an award-winning Docker Captain!
  Learn faster with included live chat group (50,000 members!) and monthly live Q&A.
- Gain the skills to build development environments with your code running in containers.
- Build Swarm and Kubernetes clusters for server deployments!
- Setup GitHub Actions to auto-build your images and scan for security vulnerabilities
  Hand's-on with best practices for making `Dockerfile`s and Compose files like a Pro!
- Build and publish your own custom images.
  Create your own custom image registry to store your apps and deploy in corporate environments.

## Image vs Container

- Image: the application we want to run
- Container: is an instance of that image running as a process
- You can have many containers running off the same image

## Starting an Nginx Container

```bash
docker container run -p 80:80 --name webhost -d nginx
```

1. Downloaded image nginx from DH
2. started new container from that image
3. Opened port 80 on host IP
4. Routes that traffic to the container IP, port 80

## Container are not Mini-VMs

- They are just processes. They are not tied to the host OS, they are isolated processes.
- Limited to what resources they can access
- Exit when the process stops unless `--rm` flag is used

## Homework

- docs.docker.com and `--help` are your friend
- Run an nginx, a mysql, and a httpd (apache) server
- Run all of `--detach` or `-d`, name them all with `--name`
- nginx should listen on `80:80`, httpd on `8080:80`, mysql on `3312:3306`
- When running mysql, use the `--env` option to pass in `MYSQL_RANDOM_ROOT_PASSWORD=yes`

## Whats going on in Containers

- `docker container top <container_id>`: process list in one container
- `docker container inspect <container_id>`: details of one container config
- `docker container stats <container_id>`: performance stats for all containers

## Getting a shell inside containers

- `docker container run -it`: start new container interactively
- `docker container exec -it`: run additional command in existing container
- Different Linux distros have different commands to get a shell in a container
  - Some use `sh`, some use `bash`

## Docker Networks: Concepts

- Each container connected to a private virtual network "bridge"
- Each virtual network routes through NAT firewall on host IP
- All containers on a virtual network can talk to each other without `-p`
- Best practice is to create a new virtual network for each app
- Battery included, but removable
- `docker container run --network <network_name>`: attach a container to a virtual network
- `docker network ls`: show networks
- `docker network inspect <network_name>`: show details of that network
- `docker network create --driver`: create a new virtual network
- `docker network connect`: attach a network to a container
- `docker network disconnect`: detach a network from a container
- `--network-alias`: add an alias to a container's hostname
- `--link`: legacy way to connect containers
- `Docker0`: default virtual network

## Docker Networks: CLI Management

- `docker network ls`: show networks
- `docker network inspect <network_name>`: show details of that network
- `docker network create --driver`: create a new virtual network
- `docker network connect`: attach a network to a container
- `docker network disconnect`: detach a network from a container
- `--network-alias`: add an alias to a container's hostname
- `--link`: legacy way to connect containers
- `Docker0`: default virtual network

## Docker Networks: DNS

- Understand how DNS is the key to easy inter-container comms
- See how it works by default with custom networks
- Learn how to use `--link` to enable DNS round robin style discovery

### Forget IPs, use DNS

- Containers should use FQDN (Fully Qualified Domain Name) to talk to each other
- Its too dynamic to try and manage IPs for containers
- Docker daemon has a built-in DNS server for containers on the same network

## Assignment Requirement: CLI App Testing

- Check curl version in ubuntu:14.04 and centos:7
- ensure curl is installed on latest version for that distro
- `docker run --rm -it ubuntu bash -c "apt-get update && apt-get install -y curl && curl --version"`
- `docker run --rm -it centos:7 /bin/bash -c "yum update -y && yum install -y curl && curl --version"`
