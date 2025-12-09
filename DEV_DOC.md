# Dev doc

## Setup

On a linux VM, preferably Debian 12.

Follow docker's installation for debian : https://docs.docker.com/engine/install/debian/
```
git clone https://github.com/0yech/inception
```

Set up .env file like mentionned in README.md
```
nano inception/srcs/.env
```
Edit hosts file to edit 42login.
```
nano /etc/hosts
```
## Run inception
```
cd inception
```

```
make re
```

## Editing inception

In `inception/srcs/requirements` you will find every service containers. they have folders named `conf` for config and `tools` for entrypoint scripts.

You can use `docker exec -it [CONTAINER_NAME]` to enter the containers interactively.
