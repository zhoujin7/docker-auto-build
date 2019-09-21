FROM golang:alpine

ENV TERM xterm
ENV TZ Asia/Shanghai

RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apk del tzdata

RUN git clone https://github.com/b3log/lute-http.git /go/src/lute-http

WORKDIR /go/src/lute-http

EXPOSE 8249

CMD ["go", "run", "main.go"]
