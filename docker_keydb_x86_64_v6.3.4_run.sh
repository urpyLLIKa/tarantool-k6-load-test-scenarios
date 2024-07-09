#!/bin/bash

keydb_ver=x86_64_v6.3.4
mkdir -p output/keydb/${keydb_ver}

docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver}
k6 run keydb/counter/redis.js > output/keydb/${keydb_ver}/counter.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver}
k6 run keydb/key-value/redis.js > output/keydb/${keydb_ver}/key-value.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver}
k6 run keydb/secondary_index/redis.js > output/keydb/${keydb_ver}/secondary_index.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver}
k6 run keydb/sets/redis.js > output/keydb/${keydb_ver}/sets.log
docker stop keydb
docker rm keydb