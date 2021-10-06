FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
LABEL version="3.8.9"
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /VAR/LOG/apache2
EXPOSE 80
RUN apt-get update && apt-get install -y apache2 apache2-utils && apt-get clean
copy index.html /var/www/html/
CMD ["apache2ctl","-D","FOREGROUND"]
