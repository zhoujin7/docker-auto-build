FROM php:7.1.1-fpm-alpine

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "--"]

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

COPY repositories /etc/apk/

RUN apk --update --no-cache add tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata 

# install php and other libraries
RUN apk -U add openssl git tar curl tini openssl ssmtp \
    # dependencies for PHP extensions below
    bzip2-dev \
    curl-dev \
    libxml2-dev \
    libpng-dev \
    imap-dev \
    icu-dev \
    libmcrypt-dev \
    sqlite-dev \
    # dependencies for PECL extensions below
    build-base \
    autoconf \
    && docker-php-ext-install \
    bcmath \
    bz2 \
    ctype \
    curl \
    dom \
    gd \
    hash \
    iconv \
    imap \
    intl \
    json \
    mbstring \
    mcrypt \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_sqlite \
    phar \
    posix \
    session \
    simplexml \
    sockets \
    xml \
    zip \
    && pecl install mongodb redis \
    && docker-php-ext-enable redis mongodb \
    && apk del build-base autoconf \
    && rm -rf /var/cache/apk/* \
    && echo "<?php phpinfo();" > /var/www/html/index.php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
     # I use Yii2 PHP Framework a lot, so I prefer this composer package be pre-installed
    && composer global require "fxp/composer-asset-plugin:^1.2.0" \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv caddy /usr/local/bin/caddy \
    && ln -sf /usr/local/etc/php /etc/php \
    && ln -sf /var/www/html /srv \
    && echo "Done"

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper
RUN chmod u+x /usr/local/bin/php-fpm-wrapper
#COPY php.ini /etc/php7/

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]