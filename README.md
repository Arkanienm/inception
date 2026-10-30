*This project has been created as part of the 42 curriculum by amurtas.*

## Description
This project aims to set up a small infrastructure composed of different services using Docker Compose. The infrastructure includes a NGINX web server supporting HTTPS/TLS v1.2/v1.3, a WordPress website powered by php-fpm, and a MariaDB database. Each service runs in its own isolated container.

## Project description & Technical Choices

### Docker Infrastructure
The project is built around microservices using Docker containers. Each service (NGINX, WordPress, MariaDB) operates in a separate container to ensure isolation, security, and ease of maintenance.

### Comparisons

#### Virtual Machines vs Docker
- **Virtual Machines**: Emulate full hardware systems, including a complete guest operating system. They are resource-heavy, slower to boot, and require dedicated RAM and storage allocations.
- **Docker Containers**: Share the host OS kernel and isolate processes at the OS level. They are lightweight, start in seconds, and consume significantly fewer system resources.

#### Secrets vs Environment Variables
- **Environment Variables**: Easily accessible key-value pairs stored in the system or specified via `.env` files. Great for non-sensitive configuration settings, but can be visible via process inspection.
- **Secrets**: Encrypted credentials and sensitive data (passwords, private keys) that are securely managed and injected only into authorized containers at runtime.

#### Docker Network vs Host Network
- **Docker Network (Bridge)**: Creates an isolated internal virtual network for containers. Communication between containers is controlled, and ports must be explicitly mapped to the host system.
- **Host Network**: The container shares the host system's network namespace directly, removing network isolation and bypassing port mapping.

#### Docker Volumes vs Bind Mounts
- **Docker Volumes (Managed/Named)**: Stored and fully managed by Docker inside `/var/lib/docker/volumes/`. They isolate data from the host filesystem structure.
- **Bind Mounts**: Mount a specific file or directory from the host system directly into the container. In this project, bind mounts are implemented inside the `volumes` section using `driver: local` and `driver_opts` (`o: 'bind'`) targeting specific host directories (`/home/amurtas/data/...`). This ensures that database and WordPress files persist directly on the host machine's disk as required by the subject guidelines, allowing easy inspection and backup by the user.

## Instructions

### Prerequisites
- Docker & Docker Compose
- `make`

### Installation & Execution
To build and start all services in detached mode:
```bash
make
```
Or
```bash
make up
```

To create dirs for mariadb and wordpress
```bash
make create_dirs
```

To down and stop all containers:
```bash
make down
```

To clean all services:
```bash
make clean
```

To rebuild the entire infrastructure:
```bash
make re
```

To clean all and delete local data:
```bash
make fclean
```

Once running access the website via:
https://amurtas.42.fr

## Resources
I used this guide to make the project : https://inception.cluzet.fr/#nginx

I used ai to understand the project and to help me with the Makefile and the README.md .