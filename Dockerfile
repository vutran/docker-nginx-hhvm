# Pull from the ubuntu:14.04 image
FROM ubuntu:14.04

# Set the author
MAINTAINER Vu Tran <vu@vu-tran.com>

# Update cache and install base packages
RUN apt-get update && apt-get -y install \
    software-properties-common \
    python-software-properties \
    debian-archive-keyring \
    wget \
    curl \
    vim \
    aptitude \
    dialog \
    net-tools \
    mcrypt \
    build-essential \
    tcl8.5 \
    git

# Add the necessary keys
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C300EE8C
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449

# Add to repository sources list
RUN add-apt-repository ppa:nginx/stable
RUN add-apt-repository 'deb http://dl.hhvm.com/ubuntu trusty main'

# Update cache and install Nginx
RUN apt-get update && apt-get -y install \
    nginx \
    hhvm

# Turn off daemon mode
# Reference: http://stackoverflow.com/questions/18861300/how-to-run-nginx-within-docker-container-without-halting
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Backup the default file
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.original

# Copy default site conf
COPY default.conf /etc/nginx/sites-available/default

# Copy the index.php file
COPY index.php /var/www/html/index.php

# Update permissions
RUN chown -R www-data:www-data /var/www/html

# Mount volumes
VOLUME ["/var/www/html"]

# Auto-configure HHVM
CMD sh /usr/share/hhvm/install_fastcgi.sh

# Start up HHVM on next boot
RUN update-rc.d hhvm defaults

# Boot up Nginx, and HHVM when container is started
CMD service hhvm start && nginx

# Set the current working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80
EXPOSE 443
