#!/bin/sh
set -e

: "${PORT:=8080}"
: "${PANEL_PATH:=panel}"
: "${WS_PATH:=ws}"
: "${XUI_USER:=admin}"
: "${XUI_PASS:?XUI_PASS is required}"
export PORT PANEL_PATH WS_PATH XUI_USER XUI_PASS

mkdir -p /etc/x-ui /run/nginx
cd /app

# پورت داخلی پنل و مسیر آن (هر بار)
./x-ui setting -port 2053 -webBasePath "/${PANEL_PATH}/"

# یوزر/پسورد فقط بار اول
if [ ! -f /etc/x-ui/.initialized ]; then
    ./x-ui setting -username "$XUI_USER" -password "$XUI_PASS"
    touch /etc/x-ui/.initialized
fi

envsubst '${PORT} ${PANEL_PATH} ${WS_PATH}' \
    < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

./x-ui &
sleep 2

# ساخت خودکار inbound و چاپ لینک در لاگ (در پس‌زمینه)
/init-inbound.sh &

exec nginx -g 'daemon off;'
