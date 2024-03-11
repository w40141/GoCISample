FROM golang:1.22 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN apk add --no-cache upx || \
  go version && \
  go mod download
COPY . .
RUN CGO_ENABLED=0 go build -buildvcs=false -trimpath -ldflags '-w -s' -o /go/bin/myapp .
RUN [ -e /usr/bin/upx ] && upx server || echo

FROM alpine:3.19.1
COPY --from=builder /go/bin/myapp /go/bin/myapp
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
EXPOSE 8080
ENTRYPOINT [ "/go/bin/myapp" ]
