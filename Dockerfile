FROM node:latest

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

ENV HOME=/usr/src/app
RUN mkdir $HOME

RUN npm install -g @angular/cli

WORKDIR $HOME
EXPOSE 4200 49153
CMD ["npm", "start"]
