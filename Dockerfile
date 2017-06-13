# FROM node:latest
# 
# MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>
# 
# RUN groupadd --gid 2000 ng-data \
#     && useradd --uid 2000 --gid ng-data --shell /bin/bash --create-home ng-data
# 
# ENV HOME=/home/ng-data APP=app 
# 
# WORKDIR $HOME
# 
# RUN npm install -g @angular/cli
# 
# COPY *.json $HOME/$APP/
# 
# RUN chown -R ng-data:ng-data $HOME/*
# 
# USER ng-data
# 
# WORKDIR $HOME/$APP
# 
# RUN npm install && npm cache clean
# 
# EXPOSE 4200 49153
# CMD ["ng", "serve"]

FROM node:6-alpine

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

RUN apk update \
  && apk add --update alpine-sdk \
  && npm install -g @angular/cli@1.1.0 \
  && ng set --global packageManager=yarn \
  && apk del alpine-sdk \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache clear \
&& sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd