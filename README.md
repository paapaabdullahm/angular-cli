## **Dockerized Angular CLI**                                       
                    
>The Angular CLI is a command line interface tool that can create a project, add files, and perform a variety of ongoing development tasks such as testing, bundling, and deployment.                    

                 
## Example Usage
               
# with docker-compose.yml file                              
          
>This setup assumes you are using nginx behind [**nginx-proxy**](https://hub.docker.com/r/jwilder/nginx-proxy/) and [**docker-gen**](https://hub.docker.com/r/jwilder/docker-gen/) discovery tool. You should also create an external network with the name: proxy-tier or similar to reference from within your compose file.                 
                       
* Make a new directory for your app and touch it with compose file          
`$ mkdir -P ~/Projects/MyApp`                        
`$ cd Projects/MyApp`                            
`$ vim docker-compose.yml`                                       
                                                                         
* Now add the following content to it and save
          
```shell
version: '2.1'

services:
  web-app:
    image: pam79/angular-cli
    container_name: web-app
    environment:
      - "PUBLIC_HOST=http://web.example.dev"
    privileged: true
    volumes:
      - ./:/MyApp:z
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
>If you run into the following issue: **Invalid Host header** when you visit your domain in a browser, it means you haven't set the **PUBLIC_HOST environment** directive inside your compose file. Set it to the url of your app to resolve this.


* Create the vhost.conf file in the root directory of your app          
`$ sudo vim vhost.conf`                                        
                                                                                     
* Add the following content to the vhost.conf file (make sure you replace **web-app** in the **proxy_pass** option below to whatever you named your application under services in the compose file above) and save it

```shell
server_names_hash_bucket_size 64;
gzip on;
gzip_disable "msie6";

gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_http_version 1.1;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

server {
  listen 80;
  server_name web.example.dev;

  location / {
    proxy_pass http://web-app:4200;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  } 
}

```                                                                     
                                                   
&nbsp;                                                                   
# lets now create a new app with it          
                        
* Open your .bashrc file and add an alias to shorten the command:          
`$ vim ~/.bashrc`                                  
                                                                       
* Add the following content at the bottom of the file (make sure to replace **web-app** with your app name) and save it          
`alias ng='docker-compose run --rm ng web-app'`                          
                                                                  
* Source it to apply new changes in the configuration file          
`$ source ~/.bashrc`                                       
                                                                        
* Create your app with the newly created 'ng' alias                  
`$  ng new my-app`                                          
                                                                     
* Add domain to host file                     
`$ sudo vim /etc/host`                                       
                                             
* Add the following to the file (your docker host ip can be used instead)      
`127.27.0.1    web.example.com`                                        
                                                                            
* Start the Application Container          
`$ docker-compose up`
                                                                                 
* Serve your app in a browser and start developing                 
`http://web.example.com`                         
                                                          

# if live-reload doesn't work, it means changes made to source are not being detected. This problem is related with Inotify Watche's Limit on Linux. Use the following solution to resolve it: 

* Vagrant Users: Install the [**vagrant-notify-forwarder**](https://github.com/mhallin/vagrant-notify-forwarder) plugin                                 
`$ vagrant plugin install vagrant-notify-forwarder`                                 
`$ vagrant reload`                                                          

> The Vagrant solution currently throws an error which terminates the watch process after it has been initialized successfully. For now the only way live-reload can work for me is to use Supervisord to manage and restart the docker-compose process whenever I make changes to the application source. Still looking for a better solution.                                                                                 

* Without Vagrant: Increase the watches limit to 512K                                    
`$ sudo sysctl fs.inotify.max_user_watches=524288`                              
`$ sudo sysctl -p --system`                                        
                                    
Good luck ____!____                                           
