*This project has been created as part of the 42 curriculum by nrey*

# Description

42's Inception project consists of learning the basics of Docker and containers. Learning about isolating and deploying services with good practices.

# Instructions

To run this Inception project, you'll need a linux VM (Debian was used here), Docker installed on your VM. Your `/etc/hosts` file edited to set up domain names.

*- /etc/hosts*
```
cheyo@vbox:~/inception$ cat /etc/hosts
127.0.0.1	localhost
127.0.1.1	vbox.myguest.virtualbox.org	vbox
127.0.0.1	cheyo.42.fr
127.0.0.1	portfolio.cheyo.42.fr
```

You will have to set your own environment variables in `inception/srcs/.env` to make it like this :

*- inception/srcs/.env* 
```
# DOMAIN
DOMAIN_NAME=XXXXX.42.fr

# DB
MYSQL_ROOT_PASSWORD=XXXXX
MYSQL_DATABASE=wordpress
MYSQL_USER=XXXXX
MYSQL_PASSWORD=XXXXX

# WORDPRESS
WP_ADMIN_USER=XXXXX
WP_ADMIN_PASSWORD=XXXXX
WP_ADMIN_EMAIL=XXXXX@XXXXX.42.fr
WP_USER=XXXXXX
WP_USER_PASSWORD=XXXXXX
WP_USER_EMAIL=XXXXX@XXXXX.42.fr

# FTP
FTP_USER=XXXXX
FTP_PASS=XXXXX
```
Of course replace the variables with yours.

# Resources

(Because new 42 subjects asks for it)
Mostly got my Docker knowledge back in 2022 with Youtube guides for the final project of my CFC in IT.
StackOverflow and random dev blogs to find quick answers on bugs.
GPT5.1 helped me for the FTP part, telling me to use another FTP server than vsftpd cause vsftpd segfaults on disconnections. (wild)
Sadly, this readme requirement just came out so i didn't list my resources.

# My inception

*Virtual Machines vs Docker*

Docker containers are meant to maintain individual (usually) isolated services. Working containers can greatly help with maintenance, as you can take a single service down without impacting the rest (unless they rely on it). Docker also offers great portability, as you can build, duplicate, reuse, whatever your images. Combined with other tools you can achieve an infrastructure with easy and great scalability.

*Secrets vs Environment Variables*

In Docker, environment variables and secrets are very similar. They are meant to provide credentials between containers. However, some images or services might end up dumping or leaking env vars, as env vars are not always meant to be private. Secrets will ensure more security as they will not be sent around the network. Docker takes care of granting the secrets to the services that were explicitly given access to them.

*Docker Network vs Host Network*

Docker offers its own network system, you can decide which containers can communicate very easily in the `docker-compose.yml` file. Containers being very small, you can take advantage of this to build many networks of tiny isolated services very easily.

*Docker Volumes vs Bind Mounts*

Both solutions offer easy access to a drive/folder, but using Docker will let you choose explicitly which container has access to the volumes you wish. My implementation of inception has the following :

- A wordpress volume.
- A mariadb container that can only access the db and not the wordpress files volume.
- A FTP service that only has access to the wordpress files volume.
- A cron service that backs up the DB in a new backup volume.

Its implementation is also very explicit in the `docker-compose.yml` file
