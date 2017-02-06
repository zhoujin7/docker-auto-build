FROM stevepacker/caddy-php7-xdebug

COPY repositories /etc/apk/

RUN apk --update upgrade

RUN apk add --update \
    tzdata \
    && rm -rf /var/cache/apk/* \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com
    
COPY php.ini /etc/php7/

ENV TZ=Asia/Shanghai 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone