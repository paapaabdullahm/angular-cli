FROM node:8.1.0-alpine

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

RUN apk update \
    && apk add --update alpine-sdk \
    && apk add --update curl \
    && npm install -g @angular/cli@1.1.0 \
    && ng set --global packageManager=yarn \
    && mkdir -p /my-app \
    && chmod 777 -R /my-app \
    && apk del alpine-sdk \
    && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
    && npm cache --force clear \
    && sed -i -e "s/bin\/bash/bin\/sh/" /etc/passwd

WORKDIR /my-app
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]
