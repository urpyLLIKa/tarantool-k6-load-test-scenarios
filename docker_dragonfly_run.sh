#!/bin/bash

dragonfly_ver=v1.20.1
mkdir -p output/dragonfly/${dragonfly_ver}

docker stop dragonfly
docker rm dragonfly
docker run -it --name dragonfly -p 6379:6379 -d docker.dragonflydb.io/dragonflydb/dragonfly:${dragonfly_ver}
k6 run dragonfly/counter/redis.js > output/dragonfly/${dragonfly_ver}/counter.log
docker stop dragonfly
docker rm dragonfly
docker run -it --name dragonfly -p 6379:6379 -d docker.dragonflydb.io/dragonflydb/dragonfly:${dragonfly_ver}
k6 run dragonfly/key-value/redis.js > output/dragonfly/${dragonfly_ver}/key-value.log
docker stop dragonfly
docker rm dragonfly
docker run -it --name dragonfly -p 6379:6379 -d docker.dragonflydb.io/dragonflydb/dragonfly:${dragonfly_ver}
k6 run dragonfly/secondary_index/redis.js > output/dragonfly/${dragonfly_ver}/secondary_index.log
docker stop dragonfly
docker rm dragonfly
docker run -it --name dragonfly -p 6379:6379 -d docker.dragonflydb.io/dragonflydb/dragonfly:${dragonfly_ver}
k6 run dragonfly/sets/redis.js > output/dragonfly/${dragonfly_ver}/sets.log
docker stop dragonfly
docker rm dragonfly