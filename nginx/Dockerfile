# Nginxのバージョンは軽量版の「alpine」
FROM nginx:alpine

COPY ./nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
