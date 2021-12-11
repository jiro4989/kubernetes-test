FROM nimlang/nim:1.6.0-alpine AS builder

WORKDIR /app
COPY . /app
RUN nimble build -Y

FROM alpine:3.13 AS runtime

COPY --from=builder /app/main /app

ENTRYPOINT ["/app"]
