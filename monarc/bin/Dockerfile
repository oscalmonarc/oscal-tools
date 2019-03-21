FROM ruby:2.5.1-alpine3.7
LABEL maintainer="bssilbe@evoforge.org"

ENV LANG C.UTF-8
ENV APP_ROOT /espresso

WORKDIR $APP_ROOT

# Setting env up
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Adding gems
COPY Gemfile $APP_ROOT/
COPY Gemfile.lock $APP_ROOT/

# Setup alpine dependencies
RUN apk --update add mariadb-dev make gcc libc-dev nodejs tzdata && \
    rm -rf /var/cache/apk/* && \
    bundle install --jobs 20 --retry 5 --without development test 

# Adding project files
COPY . $APP_ROOT/

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

