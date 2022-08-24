#!/bin/bash

# use this if container names conflicrt
# docker container rm -f web1
# docker container rm -f web2
# docker container rm -f loadbalancer1
# docker container rm -f loadbalancer2

# creating network
docker network create --subnet 10.0.0.0/24 lab

# building images
docker build -f docker/web/Dockerfile -t test/web .
docker build -f docker/lb/Dockerfile -t test/loadbalancer .

# running web servers
docker run -d --name web1 --hostname web1 --net=lab --ip="10.0.0.10" test/web
docker run -d --name web2 --hostname web2 --net=lab --ip="10.0.0.11" test/web

# running HA+keepalived loadbalancers
docker run -d --name loadbalancer1 --hostname loadbalancer1 --net=lab --ip="10.0.0.12" --sysctl net.ipv4.ip_nonlocal_bind=1 --privileged test/loadbalancer
docker run -d --name loadbalancer2 --hostname loadbalancer2 --net=lab --ip="10.0.0.13" --sysctl net.ipv4.ip_nonlocal_bind=1 --privileged test/loadbalancer

# copying keepalived conf files to containers
docker cp conf/samples/keepalived/keepalived-master.conf loadbalancer1:/etc/keepalived/keepalived.conf
docker cp conf/samples/keepalived/keepalived-backup.conf loadbalancer2:/etc/keepalived/keepalived.conf

docker container restart loadbalancer1
docker container restart loadbalancer2

# starting keepalived in containers
docker exec loadbalancer1 service keepalived start
docker exec loadbalancer2 service keepalived start