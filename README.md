# c7-systemd-dbus

The Dockerfile and the dbus.service file in this repository can be used to generate a Centos7 based docker image with support for systemd and dbus-service running inside the container.

If you want to use a pre-built docker image with this support, you can do:   
```
  docker pull diamanti/c7-systemd-dbus:latest
```

This base-image allows you to -   
1. Run multiple systemd services within the container  
2. Additionally, mount docker.sock (and /usr/bin/docker) inside this container to allow access to docker services from within the container  

Normal use case for such a container is to allow an OS independent system-container that runs multiple systemd services as well as has the ability to spawn other docker containers.  

To build this base-image:  
```
  git clone https://github.com/DatawiseIO/c7-systemd-dbus.git
  cd 7-systemd-dbus
  docker build --rm -t diamanti/c7-systemd-dbus:latest .
```

Run the docker image
```
  docker run --name=c7 --privileged -d -v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/run/docker.sock diamanti/c7-systemd-dbus:latest
```

Test it out
```
[guest@node-01]docker exec -ti c7 /bin/bash
[root@9a541c77edc2 /]# systemctl status
● 9a541c77edc2
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Tue 2016-06-28 01:06:26 UTC; 52s ago
   CGroup: /system.slice/docker-9a541c77edc22e4039f30cb505902a5673278f62cabb9451bd00b47c4cc0db18.scope
           ├─1 /usr/sbin/init
           └─system.slice
             └─systemd-journald.service
               └─17 /usr/lib/systemd/systemd-journald
               

[root@9a541c77edc2 /]# docker ps
CONTAINER ID        IMAGE                              COMMAND             CREATED              STATUS              PORTS               NAMES
9a541c77edc2        diamanti/c7-systemd-dbus:baseimg   "/usr/sbin/init"    About a minute ago   Up 59 seconds                           c7
```
