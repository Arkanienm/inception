FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /etc/mysql
RUN chmod +x /etc/mysql/script.sh

CMD [ "/etc/mysql/script.sh" ]
