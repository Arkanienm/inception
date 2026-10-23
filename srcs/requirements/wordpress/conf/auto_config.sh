#!/bin/bash
sleep 10
if [ ! -f /var/www/wordpress/wp-config.php ]
then
wp config create --allow-root \
				 --dbname=$SQL_DATABASE \
				 --dbuser=$SQL_USER \
				 --dbpass=$SQL_PASSWORD \
				 --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --url=$URL_SITE \
				--title=$TITLE_SITE \
				--admin_user=$ADMIN_USER \
				--admin_email=$ADMIN_EMAIL \
				--admin_password=$SQL_PASSWORD \
				--allow-root \
				--path='/var/www/wordpress'

wp user create $USER_LOG $USER_EMAIL --user_pass=$SQL_PASSWORD --allow-root --path='/var/www/wordpress'
fi