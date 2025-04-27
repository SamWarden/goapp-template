FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY ./cmd ./cmd
COPY ./internal ./internal

RUN go build -o ./goapp ./cmd/goapp

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/goapp ./

CMD ["./goapp"]
