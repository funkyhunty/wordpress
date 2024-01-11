FROM wordpress:latest

ARG MYSQLPASSWORD
ARG MYSQLHOST
ARG MYSQLPORT
ARG MYSQLDATABASE
ARG MYSQLUSER
ARG SIZE_LIMIT

ENV WORDPRESS_DB_HOST=$MYSQLHOST:$MYSQLPORT
ENV WORDPRESS_DB_NAME=$MYSQLDATABASE
ENV WORDPRESS_DB_USER=$MYSQLUSER
ENV WORDPRESS_DB_PASSWORD=$MYSQLPASSWORD
ENV WORDPRESS_TABLE_PREFIX="RW_"


RUN echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf
RUN echo "DirectoryIndex vimeo.php index.html" >> /etc/apache2/apache2.conf

RUN mkdir -p /var/www/html/api
COPY vimeo.php /var/www/html/api
RUN rm /var/www/html/


# Set the maximum upload file size directly in the PHP configuration
RUN echo "upload_max_filesize = $SIZE_LIMIT" >> /usr/local/etc/php/php.ini
RUN echo "post_max_size = $SIZE_LIMIT" >> /usr/local/etc/php/php.ini

CMD ["apache2-foreground"]
