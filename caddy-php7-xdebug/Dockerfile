FROM stevepacker/caddy-php7-xdebug

RUN apk --update upgrade

COPY repositories /etc/apk/

RUN apk add --update \
    tzdata \
    && rm -rf /var/cache/apk/* \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com
    
COPY php.ini /etc/php7/

ENV TZ=Asia/Shanghai 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone