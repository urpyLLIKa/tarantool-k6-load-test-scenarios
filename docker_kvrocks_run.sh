#!/bin/bash

kvrocks_ver=nightly-20240615-717e52f
mkdir -p output/kvrocks/${kvrocks_ver}

docker stop kvrocks
docker rm kvrocks
docker run -it --name kvrocks -p 6379:6666 -d apache/kvrocks:${kvrocks_ver}
k6 run kvrocks/counter/redis.js > output/kvrocks/${kvrocks_ver}/counter.log
docker stop kvrocks
docker rm kvrocks
docker run -it --name kvrocks -p 6379:6666 -d apache/kvrocks:${kvrocks_ver}
k6 run kvrocks/key-value/redis.js > output/kvrocks/${kvrocks_ver}/key-value.log
docker stop kvrocks
docker rm kvrocks
docker run -it --name kvrocks -p 6379:6666 -d apache/kvrocks:${kvrocks_ver}
k6 run kvrocks/secondary_index/redis.js > output/kvrocks/${kvrocks_ver}/secondary_index.log
docker stop kvrocks
docker rm kvrocks
docker run -it --name kvrocks -p 6379:6666 -d apache/kvrocks:${kvrocks_ver}
k6 run kvrocks/sets/redis.js > output/kvrocks/${kvrocks_ver}/sets.log
docker stop kvrocks
docker rm kvrocks