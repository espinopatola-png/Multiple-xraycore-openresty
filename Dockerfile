FROM teddysun/xray:latest AS xray-bin
FROM openresty/openresty:alpine-fat
COPY --from=xray-bin /usr/bin/xray /usr/local/bin/xray
COPY config.json /etc/xray.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
CMD ["sh", "-c", "openresty -g 'daemon off;' & /usr/local/bin/xray run -c /etc/xray.json"]
