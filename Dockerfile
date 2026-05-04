FROM teddysun/xray:latest AS x
FROM openresty/openresty:alpine-fat
COPY --from=x /usr/bin/xray /usr/bin/xray
COPY config.json /etc/xray.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
CMD ["sh", "-c", "openresty -g 'daemon off;' & /usr/bin/xray run -c /etc/xray.json"]
