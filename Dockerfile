# Railsコンテナ用Dockerfile

# イメージのベースラインにRuby2.5.1を指定
FROM ruby:2.5.1
# Railsに必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential nodejs imagemagick
# ルートディレクトリを作成
RUN mkdir /youKnow
# 作業ディレクトリを指定
WORKDIR /youKnow
# ローカルのGemfileとGemfile.lockをコピー
COPY src/Gemfile /youKnow/Gemfile
COPY src/Gemfile.lock /youKnow/Gemfile.lock
# Gemのインストール実行
RUN bundle install
# ローカルのsrcをコピー
COPY src /youKnow