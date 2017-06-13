FROM node:latest

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

RUN groupadd --gid 2000 ng-data \
    && useradd --uid 2000 --gid ng-data --shell /bin/bash --create-home ng-data

ENV HOME=/home/ng-data
WORKDIR $HOME

RUN npm install -g npm@latest && npm install -g @angular/cli

RUN chown -R ng-data:ng-data $HOME/*

USER ng-data

RUN ng new my-app && npm cache clean

EXPOSE 4200 49153
CMD ["ng", "serve"]