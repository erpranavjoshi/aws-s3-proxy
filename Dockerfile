FROM golang:1.21 AS builder
WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o aws-s3-proxy

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/aws-s3-proxy .
RUN chmod +x aws-s3-proxy
CMD ["./aws-s3-proxy"]