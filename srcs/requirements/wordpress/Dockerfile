FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt-get -y install wget

RUN apt-get install -y php8.2\
	php-fpm\
	php-mysql\
	mariadb-client -y

RUN wget https://fr.wordpress.org/wordpress-7.0.4-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-7.0.4-fr_FR.tar.gz && rm wordpress-7.0.4-fr_FR.tar.gz
RUN chown -R www-data:www-data /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY /tools/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY /conf/auto_config.sh /etc/
RUN chmod +x /etc/auto_config.sh
RUN mkdir -p /run/php
ENTRYPOINT [ "/etc/auto_config.sh" ]