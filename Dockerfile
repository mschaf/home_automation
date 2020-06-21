FROM phusion/passenger-customizable:latest AS base

RUN /pd_build/ruby-2.6.6.sh \
    && /pd_build/nodejs.sh \
    && bash  -lc 'rvm --default use 2.6.6'

RUN apt-get clean \
    && apt update \
    && apt upgrade -y \
    && apt install screen python3-pip -y \
    && pip3 install pyhs100

ADD --chown=app:app Gemfile Gemfile.lock yarn.lock package.json /application/

WORKDIR /application

RUN gem install bundler \
    && bundle config set deployment 'true' \
    && bundle config set without 'development test' \
    && bundle install --jobs 4

RUN npm install -g yarn  \
    && yarn --frozen-lockfile --no-optional --production=true --non-interactive

RUN apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=app:app . /application

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=1b696e4dada2258c632b368c67be64375c40f1fc5cba0d6208813097fa0d1d30d3afa8294889b15d2ee0bf03765f62c9d406fb050ab26157b45e18013671337a

RUN mv config/database.yml.production config/database.yml \
    && bundle exec rake webpacker:compile \
    && chown -R app:app /application

FROM base as appserver

RUN rm /etc/nginx/sites-enabled/default \
    && rm -f /etc/service/nginx/down

RUN echo "server { \n\
              listen 80; \n\
              root /application/public; \n\
              passenger_enabled on; \n\
              passenger_user app; \n\
              passenger_ruby /usr/bin/ruby2.6; \n\
              passenger_app_env production; \n\
          }" > /etc/nginx/sites-enabled/webapp.conf \
  && echo "env POSTGRES_PASSWORD;" > /etc/nginx/main.d/postgres-env.conf

EXPOSE 80

FROM base as worker

RUN mkdir /etc/service/sidekiq \
    && echo "#!/bin/bash \n\
    cd /application \n\
    exec /sbin/setuser app bundle exec sidekiq --queue default -e production -c 4" \
    > /etc/service/sidekiq/run \
    && chmod +x /etc/service/sidekiq/run