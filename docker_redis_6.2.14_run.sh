#!/bin/bash

redis_ver=6.2.14
mkdir -p output/redis/${redis_ver}

docker stop redis
docker rm redis
docker run -it --name redis -p 6379:6379 -d redis:${redis_ver}
k6 run redis/counter/redis.js > output/redis/${redis_ver}/counter.log
docker stop redis
docker rm redis
docker run -it --name redis -p 6379:6379 -d redis:${redis_ver}
k6 run redis/key-value/redis.js > output/redis/${redis_ver}/key-value.log
docker stop redis
docker rm redis
docker run -it --name redis -p 6379:6379 -d redis:${redis_ver}
k6 run redis/secondary_index/redis.js > output/redis/${redis_ver}/secondary_index.log
docker stop redis
docker rm redis
docker run -it --name redis -p 6379:6379 -d redis:${redis_ver}
k6 run redis/sets/redis.js > output/redis/${redis_ver}/sets.log
docker stop redis
docker rm redis