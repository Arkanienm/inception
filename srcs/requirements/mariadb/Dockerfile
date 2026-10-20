FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install mariadb-server -y && \
	apt install vim -y && \
	apt install curl -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start;
RUN mysql -e "CREATE DATABAASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
RUN mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
RUN mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
RUN mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
RUN mysql -e "FLUSH PRIVILEGES;"
RUN mysqladmin -u root p$SQL_ROOT_PASSWORD shutdown
RUN exec mysqld_safe

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
