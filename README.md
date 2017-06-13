# **Angular CLI**

>The Angular CLI is a command line interface tool that can create a project, add files, and perform a variety of ongoing development tasks such as testing, bundling, and deployment.

                 
## Example Usage

                 
**with docker-compose.yml file**

* This setup assumes you are using nginx behind [**nginx-proxy**](https://hub.docker.com/r/jwilder/nginx-proxy/) and [**docker-gen**](https://hub.docker.com/r/jwilder/docker-gen/) discovery tool
>You should also create an external network with the name: proxy-tier or similar along side.

               
* Make a new directory for your app and touch it with compose file

`$ mkdir -P ~/Projects/my-app`
`$ cd my-app`
`$ vim docker-compose.yml`

               
* Now add the following content to it and save

```shell
version: '2.1'

services:
  web-app:
    image: pam79/node
    container_name: web-app
    privileged: true
    volumes:
      - ./:/my-app:z
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

               
* Start the Container

`$ docker-compose up`

                 
**Lets now create a new app with it**

               
* Open your .bashrc file and add an alias to shorten the command:

`$ vim ~/.bashrc`

               
* Add following content to the bottom of the file and save it

`alias ng=docker-compose run --rm ng web-app`

               
* Source it to apply new changes in the configuration file

`$ source ~/.bashrc`

               
* Create your app with the newly created 'ng' alias

`$  ng new my-app`

               
* Move the contents of the installation directory to the parent working directory and remove the empty folder

`$ sudo mv my-app/{.,}* . && sudo rm -r my-app`

               
* Add domain to host file

`$ sudo vim /etc/ho               
* Add the following to the file

`127.27.0.1    web.example.com`


* Serve your app in a browser and start developing:

`http://web.example.com` 
