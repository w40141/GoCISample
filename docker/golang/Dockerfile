FROM golang:1.21.5-alpine

RUN apk update \
  && apk upgrade

RUN go install github.com/cosmtrek/air@latest
WORKDIR /app

CMD ["air", "-c", ".air.toml"]
