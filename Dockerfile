# Railsコンテナ用Dockerfile

# イメージのベースラインにRuby2.5.1を指定
FROM ruby:2.5.1
# Railsに必要なパッケージをインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs build-essential imagemagick
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
