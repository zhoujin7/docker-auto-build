FROM alpine:edge

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "--"]

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

# install php and other libraries
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing | tee -a /etc/apk/repositories \
    && apk --update --no-cache upgrade \
    && apk --no-cache add openssl git tar curl tini ssmtp \
        php5-bcmath \
        php5-bz2 \
        php5-ctype \
        php5-curl \
        php5-dom \
        php5-fpm \
        php5-gd \
        php5-iconv \
        php5-imap \
        php5-intl \
        php5-json \
        php5-mcrypt \
        mongo-php5-driver \
        php5-openssl \
        php5-pcntl \
        php5-pdo_mysql \
        php5-pdo_sqlite \
        php5-phar \
        php5-posix \
        php5-redis \ 
        php5-sockets \
        php5-zlib \
        php5-xdebug \
        tzdata \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php5 /usr/local/bin/php \
    && echo "clear_env = no" >> /etc/php5/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
     # I use Yii2 a lot, and it uses this composer library
    && composer global require "fxp/composer-asset-plugin:^1.2.0" \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && adduser -SDHu 1000 php \
    && sed -i "s/user *=.*$/user = php/" /etc/php5/php-fpm.conf \
    && if [ ! -f "/etc/php5/fpm.d/www.conf" ]; then touch "/etc/php5/fpm.d/www.conf"; fi  \
    && mkdir -p /srv \
    && printf "<?php phpinfo(); ?>" > /srv/index.php \
    # caddy
    && wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv /caddy /usr/local/bin/caddy

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper
RUN chmod u+x /usr/local/bin/php-fpm-wrapper
COPY php.ini /etc/php5/
COPY repositories /etc/apk/

ENV TZ=Asia/Shanghai 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]
