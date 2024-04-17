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

## What is DNS?

DNS(Domain Name System) is a system that translates domain names to IP addresses. It is a distributed database implemented in a hierarchy of name servers. Here is what happens when you use DNS

1. Lookup Request: Your device asks a DNS server for the IP address associated with a particular domain name.
2. Response: The DNS server responds with the corresponding IP address.

DNS is often described as the "phone book of the internet." Without it, we would have to remember IP addresses instead of domain names.

## DNS and Docker

n Docker, DNS is crucial for service discovery and the management of containers, especially when dealing with multi-container setups and orchestration tools like Docker Swarm or Kubernetes. Here’s how DNS ties into Docker:

- Container Networking: Docker uses DNS to manage container networking. When you create a new container, Docker automatically assigns it a unique IP address and a DNS name.
- Service Discovery: DNS is used to discover services running in other containers. Containers can communicate with each other using their DNS names.

## Assignment: DNS Round Robin Test

- Create a new virtual network
- Create two containers from `elasticsearch:2`
- Research and use `--network-alias search` when creating them to give them an additional DNS name to respond to
- Run `alpine nslookup search` with `--net` to see the two containers list for the same DNS name
- Run `centos curl -s search:9200` with `--net` multiple times until you see both containers respond
- Extra Credit: Run a single `centos` container and use `--net` to run `curl` against the `search` alias in a loop, see it hit both containers

## Commands from DNS Round Robin Test

```bash
docker network create elasticsearch
docker run -d --network elasticsearch --name elasticsearch1 --network-alias search elasticsearch
docker run -d --network elasticsearch --name elasticsearch2 --network-alias search elasticsearch
docker run --rm --network elasticsearch alpine nslookup search
```

## Container Images

## This Section

- all about images
- what is an image
- Docker Hub registry
- Managing our own local image
- Build our own image

## What is an Image and what it is not?

- app binaries and dependencies
- metadata about the image data and how to run the image
- Official definition: An image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime.
- Not complete OS. No kernel, kernel modules (e.g. drivers): The host provides the kernel, and modules, and the container runs on that kernel
- Small as one file like golang static binary
- Big as Ubuntu distro with apt, apache, php, and more installed

## Image Layers

- Images are made up of file system changes and metadata
- union file system (UFS) is a way to layer files
- history and inspect commands
- copy on write

## Docker tags

In Docker, a **tag** is a label applied to an image in a Docker registry that distinguishes different images or different versions of the same image. Tags are used to specify different versions of an image that are available, such as different versions of an operating system, different versions of a software application, or different builds of an application configured for specific purposes.

### Understanding Docker Tags

1. Basic Usage

A Docker image tag provides a convenient way to reference different versions of the same image. For example, if you have a series of images for the `ubuntu` operating system, you might have tags for each version:

- `ubuntu:18.04`
- `ubuntu:20.04`
- `ubuntu:latest`

In this example, `18.04` and `20.04` are specific versions of Ubuntu, while `latest` typically refers to the most recent stable version.

1. Components of a Tag

A Docker tag usually includes the image's repository name, followed by a colon, and the tag itself. For example:

```bash
nginx:latest
```

- **Repository Name**: `nginx`
- **Tag**: `latest`

3. Purpose and Best Practices

- **Version Control**: Tags can be used to manage different versions of applications. It is a common practice to use semantic versioning tags (like `2.5.1`, `2.5.2`, etc.) for production deployments to ensure environment consistency.
- **Environment Specific Tags**: Tags can also indicate configurations specific to environments, such as `development`, `testing`, and `production`, which may have different application settings or dependencies.
- **Builds or Revisions**: In CI/CD pipelines, tags might include build numbers or other identifiers that link the Docker image to a specific build in a build system.

### Example: Tagging an Image

When you build a Docker image, you can specify a tag with the `docker build` command:

```bash
docker build -t myapp:1.0 .
```

Here, `myapp` is the repository name, and `1.0` is the tag. Without a specified tag, Docker will default to using the `latest` tag.

### Pushing and Pulling with Tags

**Pushing an Image:**

To push an image to a Docker registry, you specify the tag:

```bash
docker push myapp:1.0
```

**Pulling an Image:**

To pull a specific version of an image from a Docker registry:

```bash
docker pull myapp:1.0
```

If no tag is specified during pull, Docker defaults to `latest`, which can lead to confusion if you expect the `latest` tag to be up-to-date with the most recent version of the image source code (it only refers to the "latest pushed" version).

### Tags and the Latest Pitfall

A common pitfall in using Docker tags is over-reliance on the `latest` tag. Since `latest` can refer to whatever was last pushed to the "latest" tag in the repository, it may not actually represent the most current version of the application. It's considered best practice in production environments to use specific, versioned tags to avoid unexpected changes.

## Persistent Data: Volumes

- defining the problem of persistent data
- key concepts with containers: immutable, ephemeral
- persistent data: databases, files, etc
- Bind mounts
- Assignments

## Container Lifetime & Persistent Data: Volumes

- Containers are usually immutable and ephemeral
- "immutable infrastructure": only re-deploy containers, never change
- This is the ideal scenario, but what about databases, or unique data?
- Docker gives us features to ensure these "separation of concerns"
- Two ways: Volumes and Bind Mounts
- Volumes: make special location outside of container UFS
- Bind Mounts: link container path to host path

## Persistent Data: Volumes Walkthrough

- `docker container run -d --name psql -e POSTGRES_HOST_AUTH_METHOD=trust postgres`
- `docker run -d --name my-postgres -e POSTGRES_PASSWORD=passwrd -v psql-data:/var/lib/postgresql/data -p 5433:5432 postgres`
- `docker run -d --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=True -p 3308:3306 -v mysql-db:/var/lib/mysql mysql`
- `docker inspect mysql | jq '.[].Mounts'`

## Create a volume

If you need to specify a driver on your volume you can create it ahead of time instead of the run command creating it for you.

## Persistent Data: Bind Mounts

- Maps a host file or directory to a container file or directory
- Basically just two locations pointing to the same file(s)
- Again, skips UFS, and host files overwrite any in container
- Can't use in Dockerfile, must be at `container run`
- `...run -v /Users/dom//stuff:/path/to/container`

## Assignment: Named Volumes

- Database upgrade with containers
- create a `postgres`(v: 9.6.1) container with named volume `psql-data` volume

## Docker Compose

- Why: configure relationships between containers
- Why: save our `docker container run` settings in easy-to-read file
- Why: create one-liner developer environment startups
- Comprised of 2 separate but related things:
  - YAML-formatted file that describes our solution options for:
    - containers
    - networks
    - volumes
  - A CLI tool `docker-compose` used for local dev/test automation with those YAML files

## `docker-compose.yml` file

- Compose YAML format as it's own versions
- `docker-compose.yml` file is a YAML file that defines how Docker containers should behave in production
- With docker directly in prod with Swarm

## Things you need in a `docker-compose.yml` file

1. Version
2. Services
   1. servicename
      1. image: optional
      2. ports: optional
      3. environment variables: optional
      4. volumes: optional
3. Networks
4. Volumes

```yml
version: "3"

services:
  servicename:
    image: imagename
    ports:
      - "80:80"
    environment:
      - key: value
    volumes:
      - volumename:/path/in/container
    networks:
      - networkname
```

- docker-compose is not a production-grade tool, but it is great for development and testing.
- comes with most installs besides linux
