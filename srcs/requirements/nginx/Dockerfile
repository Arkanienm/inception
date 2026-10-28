FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install nginx -y && \
	apt install vim -y && \
	apt install curl -y

RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Cha/L=Angouleme/O=42/OU=42/CN=amurtas.42.fr"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD [ "nginx", "-g", "daemon off;" ]