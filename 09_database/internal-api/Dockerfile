FROM nimlang/nim:1.4.2-alpine AS builder

WORKDIR /app
COPY . /app
RUN nim c -o:app main.nim

FROM alpine:3.13 AS runtime

COPY --from=builder /app/app /app
RUN apk add mariadb-connector-c-dev

ENTRYPOINT ["/app"]
