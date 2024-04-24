# Nginxのバージョンは軽量版の「alpine」
FROM nginx:alpine

# Nginxの設定ファイルをコンテナにコピー
ADD ./nginx.conf /etc/nginx/conf.d/nginx.conf

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
