# **Node.js is a JavaScript-based platform for server-side and networking applications.**

>Node.js is a software platform for scalable server-side and networking applications. Node.js applications are written in JavaScript and can be run within the Node.js runtime on Mac OS X, Windows, and Linux without changes.

&nbsp;  
## Example Usage

**with docker run**

`$ docker run -it --rm --name my-running-app  pam79/node`

&nbsp;  
**with docker-compose.yml file**

* This setup assumes you are using [**docker-gen**](https://hub.docker.com/r/jwilder/docker-gen/) and [**nginx-proxy**](https://hub.docker.com/r/jwilder/nginx-proxy/)
>You should also reate an external network with the name: proxy-tier or similar.

```shell
version: '2.1'

services:
  node-app:
    container_name: node-app
    privileged: true
    volumes:
      - ./:/usr/src/app:z
    tty: true
    stdin_open: true

    web-server:
      image: nginx:1.10
      container_name: web-server
      volumes:
        - ./vhost.conf:/etc/nginx/conf.d/default.conf
      environment:
        - "VIRTUAL_HOST=web.example.dev"
      tty: true
      stdin_open: true
      networks:
        - default

networks:
  default:
    external:
      name: proxy-tier
```
