FROM golang:alpine as GO_BUILD
RUN apk --no-cache add gcc musl-dev git
RUN git clone https://github.com/b3log/lute-http.git /go/src/github.com/b3log/lute-http --depth=1
WORKDIR /go/src/github.com/b3log/lute-http/
ENV GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.io,direct
RUN go build -i -v

FROM maven:3-jdk-8-alpine as MVN_BUILD
RUN apk --no-cache add git
RUN git clone https://github.com/b3log/solo.git /tmp --depth=1
RUN git clone https://github.com/b3log/solo-skins.git /tmp/src/main/webapp/skins --depth=1
WORKDIR /opt/solo/
RUN cd /tmp && mvn package -DskipTests -Pci && mv target/solo/* /opt/solo/ \
    && cp -f /tmp/src/main/resources/docker/* /opt/solo/WEB-INF/classes/


FROM openjdk:8-alpine
LABEL maintainer="zhoujin7<zhoujin7@foxmail.com>"

RUN apk add --no-cache ca-certificates tzdata monit
ENV TZ=Asia/Shanghai

COPY --from=GO_BUILD /go/src/github.com/b3log/lute-http/lute-http /opt/lute-http/lute-http
COPY --from=MVN_BUILD /opt/solo/ /opt/solo/

ENV solo_listen_port=8080
ENV solo_server_scheme=https
ENV solo_server_host=zhoujin7.com
ENV solo_server_port=

COPY .monitrc /root/
COPY *-lute-http.sh /opt/lute-http/
COPY *-solo.sh /opt/solo/
RUN sed -i 's/if failed port 8080 protocol http then restart/if failed port $solo_listen_port protocol http then restart/g' /root/.monitrc
RUN sed -i 's/--listen_port=8080 --server_scheme=https --server_host=zhoujin7\.com --server_port=/--listen_port=$solo_listen_port --server_scheme=$solo_server_scheme --server_host=$solo_server_host --server_port=$solo_server_port/g' /opt/solo/start-solo.sh
RUN chmod 600 /root/.monitrc
RUN chmod +x /opt/lute-http/*.sh
RUN chmod +x /opt/solo/*.sh

EXPOSE 8080

ENTRYPOINT ["monit", "-I"]
