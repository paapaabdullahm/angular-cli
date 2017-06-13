FROM ubuntu:16.04

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y python-software-properties software-properties-common build-essential git wget curl unzip ruby \
    && curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && npm install -g angular-cli@latest \
    && gem install sass \
    && ng new my-app \
    && apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) \
    && rm -rf /var/lib/apt/lists/*

WORKDIR my-app
EXPOSE 4200 49153
CMD ["ng", "serve"]
