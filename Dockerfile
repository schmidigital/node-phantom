FROM ubuntu:14.04
USER root

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# make sure apt is up to date
RUN apt-get update --fix-missing
RUN apt-get install -y curl
RUN apt-get install -y build-essential libssl-dev

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        wget \
        fontconfig \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 5.1.1

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN ln -s /usr/local/nvm/versions/v$NODE_VERSION/bin/node /usr/local/bin/node
RUN ln -s /usr/local/nvm/versions/v$NODE_VERSION/bin/npm /usr/local/bin/npm

RUN npm i -g phantomjs-prebuilt mocha sails http-server rimraf
RUN mkdir -p /usr/local/lib/node_modules/phantomjs-prebuilt/lib/phantom/bin/
RUN ln -s /usr/local/nvm/versions/v$NODE_VERSION/bin/phantomjs /usr/local/lib/node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs

EXPOSE 1337