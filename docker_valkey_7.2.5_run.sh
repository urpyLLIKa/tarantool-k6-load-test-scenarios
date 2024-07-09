#!/bin/bash

valkey_ver=7.2.5
mkdir -p output/valkey/${valkey_ver}
docker stop valkey
docker rm valkey
docker run -it --name valkey -p 6379:6379 -d valkey/valkey:${valkey_ver} 
k6 run valkey/counter/redis.js > output/valkey/${valkey_ver}/counter.log
docker stop valkey
docker rm valkey
docker run -it --name valkey -p 6379:6379 -d valkey/valkey:${valkey_ver} 
k6 run valkey/key-value/redis.js > output/valkey/${valkey_ver}/key-value.log
docker stop valkey
docker rm valkey
docker run -it --name valkey -p 6379:6379 -d valkey/valkey:${valkey_ver}
k6 run valkey/secondary_index/redis.js > output/valkey/${valkey_ver}/secondary_index.log
docker stop valkey
docker rm valkey
docker run -it --name valkey -p 6379:6379 -d valkey/valkey:${valkey_ver}
k6 run valkey/sets/redis.js > output/valkey/${valkey_ver}/sets.log
docker stop valkey
docker rm valkey