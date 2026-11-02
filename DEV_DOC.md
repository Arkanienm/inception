# Developer Documentation - Inception Infrastructure

This document outlines the architecture, setup procedure, volume management, and maintenance guidelines for developers working on the Inception infrastructure.

---

## 1. Prerequisites and Setup

### Host Prerequisites
* **Operating System**: Linux (Debian/Ubuntu-based distribution recommended within a Virtual Machine).
* **Software**: `docker`, `docker-compose-plugin` (or `docker-compose`), `make`.
* **Domain Redirection**: Update your `/etc/hosts` file on the host machine to bind your local IP to your domain name:
  ```text
  127.0.0.1 <login>.42.fr
  ```

### Directory Structure & Secrets Configuration
Before launching the stack, set up local configuration files:

1. **Environment Variables**: Ensure `srcs/.env` exists with required environment configuration:
   ```env
   DOMAIN_NAME=<login>.42.fr
   MYSQL_USER=user_name
   MYSQL_DATABASE=wordpress_db
   ```
2. **Secrets Setup**: Create secret files inside `./secrets/`:
   ```bash
   mkdir -p secrets
   echo "your_db_password" > secrets/db_password.txt
   echo "your_root_password" > secrets/db_root_password.txt
   echo "your_admin_password" > secrets/credentials.txt
   ```

---

## 2. Building and Running the Infrastructure

The build and lifecycle are managed via the root `Makefile`.

```bash
# Build Docker images and start containers in detached mode
make

# Rebuild images from scratch
make re

# Stop and remove containers and network
make down
```

---

## 3. Container Management Commands

For debugging and active development:

* **View running containers**:
  ```bash
  docker compose -f srcs/docker-compose.yml ps
  ```
* **Follow container logs**:
  ```bash
  docker compose -f srcs/docker-compose.yml logs -f
  ```
* **Access container shell**:
  ```bash
  docker compose -f srcs/docker-compose.yml exec <service_name> sh
  ```

---

## 4. Persistent Storage and Data Flow

### Volume Architecture
The project utilizes Docker **Named Volumes** configured to store persistent data on the host machine at `/home/<login>/data`:

* **WordPress Files Volume**: Standard volume mapped to `/var/www/wordpress` inside the container and persisted under `/home/<login>/data/wordpress`.
* **Database Volume**: Standard volume mapped to `/var/lib/mysql` inside the MariaDB container and persisted under `/home/<login>/data/mariadb`.

### Volume Rules & Storage Location
* Named volumes are used explicitly (Bind mounts for core WP/DB storage are strictly avoided per subject rules).
* Cleaning up containers using `docker compose down` will **not** delete volume data.
* To completely remove volume data on the host, run:
  ```bash
  make fclean
  ```
  *(Make sure host volume directories are recreated properly upon restarting).*