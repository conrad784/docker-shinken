![Shinken](http://www.shinken-monitoring.org/img/LogoFrameworkBlack.png)

[![Build Status](https://drone.xataz.net/api/badges/xataz/docker-shinken/status.svg)](https://drone.xataz.net/xataz/docker-shinken)
[![](https://images.microbadger.com/badges/image/xataz/shinken.svg)](https://microbadger.com/images/xataz/shinken "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/xataz/shinken.svg)](https://microbadger.com/images/xataz/shinken "Get your own version badge on microbadger.com")

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Features
* Based on Alpine Linux
* Latest version of Shinken
* All In One
* Persitance configuration
* No **ROOT** process
* Add your own plugins
* Graphite for beautifull graphs

## Tag available
* latest, 2.4.3, 2.4, 2 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/shinken/Dockerfile)

## Description
What is [Shinken](http://www.shinken-monitoring.org/) ?

Shinken is a modern, Nagios compatible monitoring framework, written in Python. Its main goal is to give users a flexible architecture for their monitoring system that is designed to scale to large environments.

Shinken is backwards-compatible with the Nagios configuration standard and plugins. It works on any operating system and architecture that supports Python, which includes Windows, GNU/Linux and FreeBSD.

## BUILD IMAGE
### Build Args
* SHINKEN_VER
* SHINKEN_CUSTOM_MODULES
* CUSTOM_PACKAGES
* CUSTOM_BUILD_PACKAGES
* CUSTOM_PYTHON_PACKAGES


### Simply build
```shell
docker build -t xataz/shinken github.com/xataz/dockerfiles.git#master:shinken
```

## Configuration
### Environments
* UID : Choose uid for launch shinken (default : 991)
* GID : Choose gid for launch shinken (default : 991)

### Volumes
* /shinken : Configuration files are here

### Ports
* 7767 : Port of Shinken
* 8080 : Port of Graphite

## Usage
```shell
$ docker run -d -v /docker/config/shinken:/shinken \
            -e UID=1001 -e GID=12000 \
            -p 7767:7767 \
            -p 8080:8080 \
            xataz/shinken
```

### Authentication
* Default user : admin
* Default password : password

You can change password on /shinken/htpasswd.users, for crypt password use `openssl passwd -1 password`

## Contributing
Any contributions, are very welcome !