FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt-get -y install wget

RUN apt-get install -y php8.2\
	php-fpm\
	php-mysql\
	mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY /tools/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY /conf/auto_config.sh /etc/
RUN chmod +x /etc/auto_config.sh
RUN mkdir -p /run/php
ENTRYPOINT [ "/etc/auto_config.sh" ]

URL_SITE=https://amurtas.42.fr
TITLE_SITE=amurtas_title
ADMIN_USER=anojx
ADMIN_EMAIL=anojx@angouleme.com
ADMIN_PASS=adminanojxlegoat
USER_LOG=amurtas
USER_EMAIL=amurtas@angouleme.com
USER_PASS=anojxlegoat
SQL_DATABASE=mariadb
SQL_USER=amurtas
SQL_PASSWORD=pass1
SQL_ROOT_PASSWORD=pass1