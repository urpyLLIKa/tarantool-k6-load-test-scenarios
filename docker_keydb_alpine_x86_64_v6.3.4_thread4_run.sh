#!/bin/bash

keydb_ver=alpine_x86_64_v6.3.4
mkdir -p output/keydb/${keydb_ver}_threads4

docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver} --io-threads 4
k6 run keydb/counter/redis.js > output/keydb/${keydb_ver}_threads4/counter.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver} --io-threads 4
k6 run keydb/key-value/redis.js > output/keydb/${keydb_ver}_threads4/key-value.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver} --io-threads 4
k6 run keydb/secondary_index/redis.js > output/keydb/${keydb_ver}_threads4/secondary_index.log
docker stop keydb
docker rm keydb
docker run -it --name keydb -p 6379:6379 -d eqalpha/keydb:${keydb_ver} --io-threads 4
k6 run keydb/sets/redis.js > output/keydb/${keydb_ver}_threads4/sets.log
docker stop keydb
docker rm keydb