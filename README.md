# c7-systemd-dbus

The Dockerfile and the dbus.service file in this repository can be used to generate a Centos7 based docker image with support for systemd and dbus-service running inside the container.

If you want to use a pre-built docker image with this support, you can do:   
```
  docker pull diamanti/c7-systemd-dbus
```

This base-image allows you to -   
1. Run multiple systemd services within the container  
2. Additionally, mount docker.sock (and /usr/bin/docker) inside this container to allow access to docker services from within the container  

Normal use case for such a container is to allow an OS independent system-container that runs multiple systemd services as well as has the ability to spawn other docker containers.  

To build this base-image:  
```
  docker build --rm -t diamanti/c7-systemd-dbus:baseimg .
