# **Node.js is a JavaScript-based platform for server-side and networking applications.**

>Node.js is a software platform for scalable server-side and networking applications. Node.js applications are written in JavaScript and can be run within the Node.js runtime on Mac OS X, Windows, and Linux without changes.

&nbsp;  
## Example Usage

**with docker run**

`$ docker run -it --rm --name my-app  pam79/node`

&nbsp;  
**with docker-compose.yml file**

* This setup assumes you are using [**docker-gen**](https://hub.docker.com/r/jwilder/docker-gen/) and [**nginx-proxy**](https://hub.docker.com/r/jwilder/nginx-proxy/)
>You should also reate an external network with the name: proxy-tier or similar.

&nbsp;
* Make a new directory for your app and touch it with compose file

`$ mkdir -P ~/Projects/my-app`
`$ cd my-app`
`$ vim docker-compose.yml`

&nbsp;
* Now add the following content to it and save

```shell
version: '2.1'

services:
  web-app:
    image: pam79/node
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

&nbsp;
* Start the Container
`$ docker-compose up`

&nbsp;  
**Lets now create a new app with it**
>This example is angular specific. For others please check the corresponding documentation for instructions.

&nbsp;
* Open your .bashrc file and add an alias to shorten the command:

`$ vim ~/.bashrc`

&nbsp;
* Add following content to the bottom of the file and save it

`alias ng=docker-compose run --rm ng web-app`

&nbsp;
* Source it to apply new changes in the configuration file

`$ source ~/.bashrc`

&nbsp;
* Create your app with the newly created 'ng' alias

`$  ng new my-app`

&nbsp;
* Move the contents of the installation directory to the parent working directory and remove the empty folder

`$ sudo mv my-app/{.,}* . && sudo rm -r my-app`

&nbsp;
* Add domain to host file
`$ sudo vim /etc/hosts`

`127.27.0.1    web.example.com`

&nbsp;
* Serve your app in a browser and start developing:

`http://web.example.com` 
