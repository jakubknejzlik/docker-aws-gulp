#
# Gulp image
#

FROM node:5.7

# Inspired by myprod/gulp (by Fabien D. <fabien@myprod.net>)
MAINTAINER Jakub Knejzlik <jakub.knejzlik@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    rubygems build-essential ruby-dev \
    && rm -rf /var/lib/apt/lists/*
    
# Install Gulp & Bower
RUN apt-get update && \
  apt-get install unzip curl -y && \
  mkdir /tmp/aws && \
  cd /tmp/aws && \
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
  unzip awscli-bundle.zip && \
  ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
  rm -rf /tmp/aws


# Install Gulp & Bower
RUN npm install -gq gulp bower

# Install Gem Sass Compass
RUN gem install sass

RUN usermod -u ${DOCKER_USER_ID:-1000} www-data \
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}
