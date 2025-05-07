FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY ./cmd ./cmd
COPY ./internal ./internal

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN go build -o ./goapp ./cmd/goapp

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/goapp ./

CMD ["./goapp"]
