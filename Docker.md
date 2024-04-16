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
