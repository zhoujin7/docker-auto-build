FROM golang:latest as GO_BUILD

RUN git clone https://github.com/b3log/lute-http.git /go/src/lute-http
WORKDIR /go/src/lute-http
RUN go build -i -v


FROM alpine:latest

ENV TERM xterm
ENV TZ Asia/Shanghai

RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apk del tzdata

COPY --from=GO_BUILD /go/src/lute-http/lute-http /root/lute-http

EXPOSE 8249

ENTRYPOINT [ "/root/lute-http" ]
