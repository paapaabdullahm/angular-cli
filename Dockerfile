FROM ubuntu:16.04

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    NODE_VERSION=6.10.3 \
    NPM_VERSION=5.0.1 \
    CLI_VERSION=latest \
    HOME=/usr/src/my-app

RUN mkdir -p $HOME
WORKDIR $HOME
COPY *.json .

RUN apt-get update \
    && apt-get install -y python-software-properties software-properties-common build-essential git wget curl unzip ruby \
    && curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs \
    && npm install -g npm@"$NPM_VERSION" \
    && npm install -g angular/cli@"$CLI_VERSION" \
    && gem install sass \
    && ng new my-app \
    && mv -f my-app/{.,}* . \
    && rm -r my-app

EXPOSE 4200 49153
CMD ["ng", "serve"]
