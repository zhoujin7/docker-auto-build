#!/bin/bash

function exportBoolean {
    if [ "${!1}" = "**Boolean**" ]; then
            export ${1}=''
    else 
            export ${1}='Yes.'
    fi
}

exportBoolean LOG_STDOUT
exportBoolean LOG_STDERR

if [ $LOG_STDERR ]; then
    /bin/ln -sf /dev/stderr /var/log/apache2/error.log
else
	LOG_STDERR='No.'
fi

if [ $ALLOW_OVERRIDE == 'All' ]; then
    /bin/sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/apache2/apache2.conf
fi

if [ $LOG_LEVEL != 'warn' ]; then
    /bin/sed -i "s/LogLevel\ warn/LogLevel\ ${LOG_LEVEL}/g" /etc/apache2/apache2.conf
fi

# enable php short tags:
/bin/sed -i "s/short_open_tag\ \=\ Off/short_open_tag\ \=\ On/g" /etc/php/7.0/apache2/php.ini

# stdout server info:
if [ ! $LOG_STDOUT ]; then
cat << EOB
    
    **********************************************
    *                                            *
    *    Docker image: jin7/lamp                 *
    *                                            *
    **********************************************

    SERVER SETTINGS
    ---------------
    · Redirect Apache access_log to STDOUT [LOG_STDOUT]: No.
    · Redirect Apache error_log to STDERR [LOG_STDERR]: $LOG_STDERR
    · Log Level [LOG_LEVEL]: $LOG_LEVEL
    · Allow override [ALLOW_OVERRIDE]: $ALLOW_OVERRIDE
    · PHP date timezone [DATE_TIMEZONE]: $DATE_TIMEZONE

EOB
else
    /bin/ln -sf /dev/stdout /var/log/apache2/access.log
fi

# Set PHP timezone
/bin/sed -i "s/\;date\.timezone\ \=/date\.timezone\ \=\ ${DATE_TIMEZONE}/" /etc/php/7.0/apache2/php.ini

# # Run Postfix
# /usr/sbin/postfix start

# #Run MySQL
# /usr/bin/mysqld_safe --timezone=${DATE_TIMEZONE}&

# #Run Apache:
# if [ $LOG_LEVEL == 'debug' ]; then /usr/sbin/apachectl -DFOREGROUND -k start -e debug; else &>/dev/null /usr/sbin/apachectl -DFOREGROUND -k start; 
# fi

init_mysql(){
    VOLUME_HOME="/var/lib/mysql"
    # Now we are going to bind to all interfaces for easy access. Do not do this on production a server unless MySQL is secured!
    # sed -ri -e "s/^bind-address.*/bind-address\t\t=     0\.0\.0\.0/" /etc/mysql/mysql.conf.d/mysqld.cnf 
    if [[ ! -d $VOLUME_HOME/mysql ]]; then
        echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
        echo "=> Installing MySQL ..."
        # mysql_install_db > /dev/null 2>&1 Removed by A. Datta
        /usr/sbin/mysqld --initialize-insecure > /dev/null 2>&1 # Line added by A. Datta
        echo "=> Done!"  
    else
        echo "=> Using an existing volume of MySQL"
    fi
}

init_mysql();
exec supervisord -n
