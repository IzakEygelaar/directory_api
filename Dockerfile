FROM ruby:2.5.0-alpine3.7
LABEL maintainer="Izak Eygelaar"
RUN apk add --update --no-cache \
       build-base \
       tzdata \
       libxml2-dev \
       libxslt-dev \
       bash \
       curl \
    && rm -rf /var/cache/apk/*

WORKDIR /srv/dir_api
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD bundle exec rackup -p 8080 config.ru --host 0.0.0.0
