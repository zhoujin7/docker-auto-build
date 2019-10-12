FROM tomcat:alpine

ENV TERM xterm
ENV TZ Asia/Shanghai

RUN apk --no-cache add tzdata && \
cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
