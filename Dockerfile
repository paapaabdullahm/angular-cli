FROM node:8.1.0-alpine

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

RUN apk update \
    && apk add --update alpine-sdk \
    && npm install -g @angular/cli@1.1.0 \
    && ng new my-app \
    && apk del alpine-sdk \
    && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
    && npm cache --force clear \
    && sed -i -e "s/bin\/bash/bin\/sh/" /etc/passwd

WORKDIR my-app
EXPOSE 4200 49153
CMD ["ng", "serve"]
