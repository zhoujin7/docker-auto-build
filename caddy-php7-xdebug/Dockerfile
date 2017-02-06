FROM stevepacker/caddy-php7-xdebug

RUN apk --update --no-cache upgrade \
    && apk add --no-cache tzdata \
    && rm -rf /var/cache/apk/* \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com
    
COPY php.ini /etc/php7/
COPY repositories /etc/apk/

ENV TZ=Asia/Shanghai 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone