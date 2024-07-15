#!/bin/bash

garnet_ver=sha-805c5d6
mkdir -p output/garnet/${garnet_ver}

docker stop garnet
docker rm garnet
docker run -it --name garnet -p 6379:6379 -d ghcr.io/microsoft/garnet:${garnet_ver}
k6 run garnet/counter/redis.js > output/garnet/${garnet_ver}/counter.log
docker stop garnet
docker rm garnet
docker run -it --name garnet -p 6379:6379 -d ghcr.io/microsoft/garnet:${garnet_ver}
k6 run garnet/key-value/redis.js > output/garnet/${garnet_ver}/key-value.log
docker stop garnet
docker rm garnet
docker run -it --name garnet -p 6379:6379 -d ghcr.io/microsoft/garnet:${garnet_ver}
k6 run garnet/secondary_index/redis.js > output/garnet/${garnet_ver}/secondary_index.log
docker stop garnet
docker rm garnet
docker run -it --name garnet -p 6379:6379 -d ghcr.io/microsoft/garnet:${garnet_ver}
k6 run garnet/sets/redis.js > output/garnet/${garnet_ver}/sets.log
docker stop garnet
docker rm garnet