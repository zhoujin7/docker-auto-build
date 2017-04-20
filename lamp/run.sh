#!/bin/bash

#sed -ri -e "s/^bind-address.*/bind-address\t\t= 	0\.0\.0\.0/" /etc/mysql/mysql.conf.d/mysqld.cnf 

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    /usr/sbin/mysqld --initialize-insecure > /dev/null 2>&1 
    echo "=> Done!"  
else
    echo "=> Using an existing volume of MySQL"
fi

exec supervisord -n
