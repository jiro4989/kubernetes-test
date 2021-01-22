FROM golang:1.15.7-alpine3.13 AS builder

WORKDIR /app
COPY . /app
RUN go build -o app .

FROM alpine:3.13 AS runtime

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
