FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x tools/script.sh

COPY tools/script.sh /etc/mysql


CMD [ "/etc/mysql/script.sh" ]
