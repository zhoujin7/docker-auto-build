FROM tomcat:alpine

ENV TZ Asia/Shanghai
ENV TERM xterm

RUN apk --update add tzdata && \
cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
apk del tzdata
