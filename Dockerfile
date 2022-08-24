FROM golang:1.18.3-alpine3.15 as builder
COPY . /usr/local/go/src/upload-actions
WORKDIR /usr/local/go/src/upload-actions
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 GO111MODULE=on GOPROXY=https://goproxy.mirror.mystery0.app/,direct go build -o /usr/bin/upload-actions upload-actions

###
FROM alpine:3.15.0 as final
ENTRYPOINT ["/usr/bin/upload-actions"]
COPY --from=builder /usr/bin/upload-actions /usr/bin/