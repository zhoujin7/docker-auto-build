FROM stevepacker/caddy-php7-xdebug
COPY repositories /etc/apk/
RUN apk add --update \
    tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com
COPY php.ini /etc/php7/
