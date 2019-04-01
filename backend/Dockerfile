FROM ruby:2.5.3-alpine3.8
MAINTAINER lasong

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                tzdata

RUN gem install bundler

RUN mkdir /usr/src/backend
WORKDIR /usr/src/backend

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc
COPY Gemfile* /usr/src/backend/

RUN bundle install --jobs 20 --retry 5
ADD . /usr/src/backend
EXPOSE 3000

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rails", "s", "-b", "0.0.0.0"]
