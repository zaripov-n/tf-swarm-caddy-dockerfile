#!/bin/sh

# 1. Секреты для S3 хранилища
export S3_ACCESS_KEY_ID=$(cat /run/secrets/s3_access_key)
export S3_SECRET_KEY=$(cat /run/secrets/s3_secret_key)

# 2. Секрет для DNS (lego подхватывает этот путь сам)
# Важно: lego для yandex умеет читать либо токен, либо файл ключа
export YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE="/run/secrets/yc_dns_key_json"

exec "$@"
