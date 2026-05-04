FROM teddysun/xray:latest AS xray-bin
FROM openresty/openresty:alpine-fat

RUN apk add --no-cache ca-certificates bash curl
COPY --from=xray-bin /usr/bin/xray /usr/local/bin/xray
COPY config.json /etc/xray.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN chmod +x /usr/local/bin/xray
EXPOSE 8080

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

CMD /usr/local/bin/xray run -c /etc/xray.json & /usr/local/openresty/bin/openresty -g 'daemon off;'
