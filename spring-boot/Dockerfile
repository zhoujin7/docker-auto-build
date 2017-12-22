FROM openjdk:8-jdk
MAINTAINER zhoujin7 <jin7boy@gmail.com>

ENV JAVA_HOME              /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_OPTS              ""
ENV PATH                   $PATH:$JAVA_HOME/bin

ENV TZ              Asia/Shanghai
ENV SPRING_PROFILES_ACTIVE test

RUN echo "$TZ" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

EXPOSE 80

ONBUILD COPY app.jar /app/app.jar

CMD ["/bin/sh", "-c", "java $JAVA_OPTS -jar /app/app.jar --spring.profiles.active=$SPRING_PROFILES_ACTIVE"]
