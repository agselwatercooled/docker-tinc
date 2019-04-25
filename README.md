# agsel/tinc (Docker Hub) / docker-tinc (GitHub) 

This image contains the TincVPN binaries and is based on alpine linux  
NOTE: This image was only tested on a linux host system


## Getting Started

These instructions will cover usage information for the docker container 


### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

Knowledge about Tinc VPN and its configuration is also necessary.

* [Tinc VPN](https://www.tinc-vpn.org/)
* [Tutorial for Tinc VPN from linode.com](https://www.linode.com/docs/networking/vpn/how-to-set-up-tinc-peer-to-peer-vpn/)


### Usage

#### Tinc Configuration Files
You need to provide the configuration files with the default file/folder structure as used for a "native" running TincVPN. The following folder structure is based on the linode.com tutorial:  
```
linodeVPN
|-- hosts
|   |-- appserver
|   |-- dbserver
|   `-- webserver
|-- rsa_key.priv
|-- rsa_key.pub
|-- tinc.conf
|-- tinc-down
`-- tinc-up
```


#### Container Parameters

This container needs the NET_ADMIN rights

```shell
docker run --init --mount type=bind,readonly,source=*ABSOLUTE-PATH-TO-YOUR-CONFIG-FOLDER*,target=/etc/tinc/*VPN-NETWORK-NAME* --network *DOCKER-NETWORK* --cap-add NET_ADMIN agsel/tinc "-n *VPN-NETWORK-NAME* -D"
```

Sample command based on the linode.com tutorial. This container shares the vpn connection with the host system (*--network host*):
```shell
docker run --init --mount type=bind,readonly,source=/home/tincVPN/linodeVPN,target=/etc/tinc/linodeVPN --network host --cap-add NET_ADMIN agsel/tinc "-n linodeVPN -D"
```

Sample docker-compose.yml file:
```
version: '3'

services:
  tinc:
    image: agsel/tinc
    container_name: tinc
    network_mode: host
    volumes:
      - /home/tincVPN/linodeVPN:/etc/tinc/hadoopVPN
    command: ["-n hadoopVPN -D -d2"]
    cap_add:
      - NET_ADMIN

```

## Authors

* [**Alexander Gut**](https://github.com/agselwatercooled)
