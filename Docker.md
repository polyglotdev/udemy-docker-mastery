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
docker container run -p 80:80 --detach --name webhost nginx
```
