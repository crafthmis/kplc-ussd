ARG RUBY_VERSION
# See explanation below
#FROM ruby:$RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

LABEL maintainer="dunake@gmail.com"

ARG PG_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
#FROM ruby:2.7-slim

# ENV PG_MAJOR $PG_MAJOR
# ENV NODE_MAJOR  $NODE_MAJOR
# ENV BUNDLER_VERSION $BUNDLER_VERSION
# ENV YARN_VERSION $YARN_VERSION



ENV ORACLE_HOME "/usr/lib/oracle/19.6/client64"
ENV LD_LIBRARY_PATH "$ORACLE_HOME/lib"
ENV PATH "$PATH:$ORACLE_HOME/bin"

COPY \
  vendor/oracle-instantclient19.8-basic-19.8.0.0.0-1.x86_64.rpm\
  vendor/oracle-instantclient19.8-devel-19.8.0.0.0-1.x86_64.rpm\
  vendor/oracle-instantclient19.8-sqlplus-19.8.0.0.0-1.x86_64.rpm\
  /tmp/

RUN set -ex && \
  BUILD_PACKAGES='alien build-essential libaio-dev' && \
  apt-get update && \
  apt-get install -y --no-install-recommends $BUILD_PACKAGES libaio1 && \
  for f in /tmp/oracle-*.rpm; do alien -i $f; done && \
  apt-get purge -y --auto-remove $BUILD_PACKAGES && \
  rm -rf /tmp/*.rpm && \
  echo /usr/lib/oracle/19.6/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.6.conf && \
  ldconfig


# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

#ENV CURRENT_USER $USER_ID
# RUN mkdir -p $INSTALL_PATH
# RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
#   && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stable main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update -qq \
#   && apt-get install -y curl \
#   && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
#   && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#   && apt-get update -qq \
#   && apt-get install -y nodejs yarn postgresql-client \
#   && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

COPY Aptfile /tmp/Aptfile
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
    nodejs \
    yarn \
    $(cat /tmp/Aptfile | xargs) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log
# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

RUN mkdir -p /app
#RUN gem install bundler -v 2.0.2
#RUN gem install rails
#COPY Gemfile* ./
#WORKDIR /opt/app/mrgreen
#RUN bundle install
#COPY package.json yarn.lock /
#RUN yarn install --check-files
#RUN chown -R user:user /app
#USER user

#VOLUME ["$INSTALL_PATH/public"]

#RUN chown -R user:user /app
#USER user

WORKDIR /app
#CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]