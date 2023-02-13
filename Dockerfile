# Base image
FROM ubuntu:22.04

# Maintainer information
MAINTAINER Muhammad Usama

# Setting up base image
RUN apt-get update && apt-get upgrade -y

# Installation MariaDB
RUN apt-get install -y  software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
RUN add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main" --yes
RUN apt -y install mariadb-server mariadb-client

# Installation SSH and Root Access
RUN apt-get install -y nano openssh-server
RUN mkdir /var/run/sshd
RUN echo root:root | chpasswd
RUN echo 'PermitRootLogin yes' | tee -a /etc/ssh/sshd_config

# Installation PHP, php-plugins and Composer
RUN ENV DEBIAN_FRONTEND=noninteractive
RUN echo "Asia" > /etc/timezone && ln -fs /usr/share/zoneinfo/Asia/Karachi /etc/localtime
RUN add-apt-repository ppa:ondrej/php --yes
RUN apt -y install php7.4
RUN apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath

RUN apt install -y curl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Installation Apache2
RUN apt install -y apache2

# Installation GIT
RUN apt install -y git

# Installation Nodejs
RUN apt install -y nodejs

# Installation NPM
RUN apt install -y npm

# Installation other utilities
RUN apt-get install -y wget nano iputils-ping


#exposing ports
EXPOSE 80
EXPOSE 22
EXPOSE 3306
EXPOSE 4444
EXPOSE 4567
EXPOSE 4568

# Copy runservices.sh to the root directory of container
COPY runservices.sh /
chmod +x /runservices.sh

#run runservice.sh inside contanier
CMD ["/runservices.sh"]

