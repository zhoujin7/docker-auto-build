FROM golang:alpine as GO_BUILD
RUN apk --no-cache add gcc musl-dev git
RUN git clone https://github.com/b3log/lute-http.git /go/src/github.com/b3log/lute-http
WORKDIR /go/src/github.com/b3log/lute-http/
RUN sed -i "s/127\.0\.0\.1:8249/0\.0\.0\.0:8249/g" main.go
ENV GO111MODULE=on
RUN go build -i -v

FROM maven:3-jdk-8-alpine as MVN_BUILD
WORKDIR /opt/solo/
RUN git clone https://github.com/b3log/solo.git /tmp --depth=1
RUN cd /tmp && mvn package -DskipTests -Pci && mv target/solo/* /opt/solo/ \
    && cp -f /tmp/src/main/resources/docker/* /opt/solo/WEB-INF/classes/


FROM openjdk:8-alpine
LABEL maintainer="zhoujin7<zhoujin7@foxmail.com>"

RUN apk add --no-cache ca-certificates tzdata monit
ENV TZ=Asia/Shanghai

COPY --from=GO_BUILD /go/src/github.com/b3log/lute-http/lute-http /opt/lute-http/lute-http
COPY --from=MVN_BUILD /opt/solo/ /opt/solo/
COPY solo.conf /etc/monit.d/

EXPOSE 8080

ENTRYPOINT ["monit", "-I"]
