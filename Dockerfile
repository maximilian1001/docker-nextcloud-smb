FROM nextcloud:30-apache

# replaced smbclient because of errors on files >512MB
# RUN apt-get update && apt-get install -y procps smbclient && rm -rf /var/lib/apt/lists/*

# stolen from https://github.com/icsy7867/nextcloud/blob/master/nextcould-23/Dockerfile
RUN apt-get update && apt-get install -y smbclient libsmbclient-dev
RUN pecl install smbclient
RUN echo "extension=smbclient.so" >> /usr/local/etc/php/conf.d/nextcloud.ini
