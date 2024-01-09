## build stage
FROM ruby:3.1.4-alpine3.18 AS builder
ENV TZ=Asia/Tokyo \
    LANG=C.UTF-8
RUN apk update && \
    apk add --virtual build-packs --no-cache \
            alpine-sdk \
            build-base \
            curl-dev \
            mysql-dev \
            tzdata
WORKDIR /backend
COPY Gemfile Gemfile.lock /app/
RUN bundle install
RUN apk del build-packs

## production stage
FROM ruby:3.1.4-alpine3.18
ENV TZ=Asia/Tokyo \
    LANG=C.UTF-8 \
    RAILS_ENV=production
RUN apk add --no-cache \
            bash \
            mysql-dev \
            tzdata
WORKDIR /backend
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /backend
# tmp, publicディレクトリを作成
RUN mkdir -p tmp/sockets tmp/pids
VOLUME /backend/public
VOLUME /backend/tmp
# コンテナ起動に必要な初期設定
COPY entrypoint.sh /usr/bin/
# entrypoint.shを実行可能にする
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# ポート3001番を開放
EXPOSE 3001
# オプションとして、コンテナ外部からのアクセスを許可
CMD ["rails", "server", "-b", "0.0.0.0"]
