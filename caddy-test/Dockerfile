# Используем стабильную версию (2.8.4 на текущий момент)
ARG CADDY_VERSION=2.11.2
FROM caddy:${CADDY_VERSION}-builder AS builder

# Устанавливаем лимиты для Go, чтобы он не забивал диск временными файлами
ENV GOCACHE=/tmp/go-cache
ENV GOPATH=/tmp/go-path

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/lego-deprecated \
    --with github.com/fvbommel/caddy-combine-ip-ranges \
    --with github.com/techknowlogick/certmagic-s3 && \
    # Очищаем кэш сразу после сборки, чтобы не раздувать слои
    go clean -cache -modcache

FROM caddy:${CADDY_VERSION}-alpine

RUN apk add --no-cache ca-certificates nss-tools curl

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
