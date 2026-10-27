#!/bin/bash
sleep 10
if ! wp core is-installed --allow-root ; then
wp config create --allow-root \
				 --dbname=$SQL_DATABASE \
				 --dbuser=$SQL_USER \
				 --dbpass=$SQL_PASSWORD \
				 --dbhost=mariadb:3306 \
				 --path='/var/www/wordpress' --force

wp core install --url=$URL_SITE \
				--title=$TITLE_SITE \
				--admin_user=$ADMIN_USER \
				--admin_email=$ADMIN_EMAIL \
				--admin_password=$ADMIN_PASS \
				--allow-root \
				--path='/var/www/wordpress' \
				--skip-email

wp user create $USER_LOG $USER_EMAIL --user_pass=$USER_PASS --allow-root --role=author --path='/var/www/wordpress'
fi

chown -R www-data:www-data /var/www/wordpress
exec /usr/sbin/php-fpm8.2 -F
