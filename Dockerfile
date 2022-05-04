FROM ruby:2.7.3-alpine3.13

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc g++ libc-dev mysql-client mysql-dev nodejs tzdata npm yarn git" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    apk add vim && \
    apk add python2 && \
    apk add -u yarn && \
    apk del build-dependencies

ENV APP_ROOT /sample_app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle install -j4

COPY . $APP_ROOT

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
