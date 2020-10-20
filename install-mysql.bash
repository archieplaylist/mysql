#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive

## Setup the root user password
debconf-set-selections <<< "mysql-server mysql-server/root_password password password"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password password"

## Update the apt lists
apt-get update
apt-get upgrade -y

# apt purge mysql-client-5.7 mysql-client-core-5.7 mysql-common mysql-server-5.7 mysql-server-core-5.7 mysql-server
# apt update && sudo apt upgrade -y  && \
#      apt autoremove && apt -f install -y


## Install MySQL
apt-get install -y mysql-server tzdata
# apt-get install -y mysql-server-${MYSQL_MAJOR} tzdata

## Clean up any mess
apt-get clean autoclean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*

## Empty out the default MySQL data directory, its for our entrypoint script
rm -rf /var/lib/mysql
mkdir -p /var/lib/mysql
