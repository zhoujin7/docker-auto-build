FROM ubuntu:16.04
MAINTAINER jin7 <zhoujin7@foxmail.com>
LABEL Description="Cutting-edge LAMP stack, based on Ubuntu 16.04 LTS. Includes .htaccess support and popular PHP7 features, including composer and mail() function." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql jin7/lamp" \
	Version="1.0"

RUN apt-get update
RUN apt-get upgrade -y

COPY debconf.selections /tmp/
RUN debconf-set-selections /tmp/debconf.selections

RUN apt-get install -y \
	php7.0 \
	php7.0-bz2 \
	php7.0-cgi \
	php7.0-cli \
	php7.0-common \
	php7.0-curl \
	php7.0-dev \
	php7.0-enchant \
	php7.0-fpm \
	php7.0-gd \
	php7.0-gmp \
	php7.0-imap \
	php7.0-intl \
	php7.0-json \
	php7.0-ldap \
	php7.0-mcrypt \
	php7.0-mysql \
	php7.0-odbc \
	php7.0-opcache \
	php7.0-pgsql \
	php7.0-phpdbg \
	php7.0-pspell \
	php7.0-readline \
	php7.0-recode \
	php7.0-snmp \
	snmp \
	php7.0-sqlite3 \
	php7.0-tidy \
	php7.0-xmlrpc \
	php7.0-xsl \
	php7.0-zip \
	php7.0-mbstring \
	php-redis \
	php-xdebug

RUN apt-get install supervisor -y
RUN apt-get install apache2 libapache2-mod-php7.0 -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install mysql-common mysql-server mysql-client -y
RUN apt-get install postfix -y
RUN apt-get install nano tree vim curl -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& composer config -g repo.packagist composer https://packagist.phpcomposer.com

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE Asia/Shanghai
ENV TERM dumb

COPY index.php /var/www/html/
COPY sources.list /etc/apt/
COPY php.ini /etc/php/7.0/apache2/
COPY dir.conf /etc/apache2/mods-enabled/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN a2enmod rewrite
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /var/log/supervisor

VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /var/lib/mysql
VOLUME /var/log/mysql

EXPOSE 80
EXPOSE 3306

CMD ["/usr/sbin/run-lamp.sh"]