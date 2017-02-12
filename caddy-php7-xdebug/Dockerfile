FROM alpine:edge

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "--"]

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

# install php and other libraries
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing | tee -a /etc/apk/repositories \
    && apk --update --no-cache upgrade \
    && rm -rf /var/cache/apk/*

RUN apk --no-cache add openssl git tar curl tini ssmtp \
    && rm -rf /var/cache/apk/*

RUN apk --no-cache add php7-bcmath \
        php7-bz2 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-imap \
        php7-intl \
        php7-json \
        php7-mcrypt \
        php7-mbstring \
        php7-mongodb \
        php7-openssl \
        php7-pcntl \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-phar \
        php7-posix \
        php7-redis \ 
        php7-session \
        php7-sockets \
        php7-zlib \
        php7-xdebug \
    && rm -rf /var/cache/apk/*

RUN apk --no-cache add php7-mysqli \
        php7-zip \
    && rm -rf /var/cache/apk/*

RUN apk --no-cache add tzdata \
    && rm -rf /var/cache/apk/*

RUN ln -s /usr/bin/php7 /usr/local/bin/php \
    && echo "clear_env = no" >> /etc/php7/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
     # I use Yii2 a lot, and it uses this composer library
    && composer global require "fxp/composer-asset-plugin:^1.2.0" \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && adduser -SDHu 1000 php \
    && sed -i "s/user *=.*$/user = php/" /etc/php7/php-fpm.conf \
    && mkdir -p /srv \
    && printf "<?php phpinfo(); ?>" > /srv/index.php \
    # caddy
    && wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv /caddy /usr/local/bin/caddy

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper
RUN chmod u+x /usr/local/bin/php-fpm-wrapper
COPY php.ini /etc/php7/
COPY repositories /etc/apk/

ENV TZ=Asia/Shanghai 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]
