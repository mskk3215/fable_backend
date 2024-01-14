## build stage
FROM ruby:3.1.2 AS builder
ENV TZ=Asia/Tokyo \
    LANG=C.UTF-8
# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    default-libmysqlclient-dev \
    tzdata
WORKDIR /backend
COPY Gemfile Gemfile.lock /backend/
RUN gem install bundler -v '2.3.22'
RUN bundle install

FROM ruby:3.1.2
ENV TZ=Asia/Tokyo \
    LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    default-mysql-client \
    tzdata
WORKDIR /backend
# Gemfile, Gemfile.lockをコピー
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /backend
# tmp, publicディレクトリを作成
RUN mkdir -p tmp/sockets tmp/pids
# コンテナ起動に必要な初期設定
COPY entrypoint.sh /usr/bin/
# entrypoint.shを実行可能にする
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# ポート3001番を開放
EXPOSE 3001
# オプションとして、コンテナ外部からのアクセスを許可
CMD ["rails", "server", "-b", "0.0.0.0"]
