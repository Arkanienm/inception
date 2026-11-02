# User Documentation - Inception Infrastructure

This documentation provides end-users and administrators with simple instructions on how to access, monitor, and manage the services hosted by the Inception infrastructure.

---

## 1. Overview of Services

The infrastructure runs a set of containerized services:
* **NGINX**: Serves as the sole entry point to the infrastructure via HTTPS (Port 443), securing connections using TLSv1.2/TLSv1.3.
* **WordPress + PHP-FPM**: Powers the main website and administrative backend.
* **MariaDB**: Stores all relational data for the WordPress site.

---

## 2. Starting and Stopping the Project

All service management is executed via the `Makefile` located at the root of the repository.

* **Start the infrastructure**:
  ```bash
  make
  ```
  *(or `make all` / `make up` depending on setup)*

* **Stop the infrastructure** (without removing persistent data):
  ```bash
  make down
  ```

* **Clean up services and containers**:
  ```bash
  make clean
  ```

* **Perform a complete purge** (stops services, removes containers, networks, images, and stored volume data):
  ```bash
  make fclean
  ```

---

## 3. Accessing the Services

### Website Access
* **URL**: `https://<login>.42.fr` *(replace `<login>` with your actual 42 login)*
* **Note**: Only HTTPS over port 443 is available. Plain HTTP requests (port 80) are disabled by design.

### WordPress Administration Panel
* **URL**: `https://<login>.42.fr/wp-admin`
* Use your assigned administrator credentials to log in and manage site content, plugins, and settings.

---

## 4. Credentials and Secrets

Secrets and credentials are keep secured and out of version control.

* **Location of Secrets**: Secrets are stored in local files inside the `./secrets/` directory on the host:
  * `./secrets/credentials.txt`
  * `./secrets/db_password.txt`
  * `./secrets/db_root_password.txt`
* **Environment Variables**: Non-sensitive variables (such as `DOMAIN_NAME`) are stored in `srcs/.env`.
* **Important**: Never commit files in `./secrets/` or private variables in `.env` to Git repository.

---

## 5. Service Health & Status Verification

To check whether all containers and services are operating properly:

1. **Check Container Status**:
   ```bash
   docker ps
   ```
   Ensure NGINX, WordPress, and MariaDB containers display a status of `Up`.

2. **Inspect Service Logs**:
   To view logs for troubleshooting:
   ```bash
   docker-compose -f srcs/docker-compose.yml logs -f [service_name]
   ```
   *(Replace `[service_name]` with `nginx`, `wordpress`, or `mariadb`)*

3. **Verify HTTPS/TLS**:
   Use `curl` to test connection protocols:
   ```bash
   curl -I -k --tls-max 1.3 https://<login>.42.fr
   ```