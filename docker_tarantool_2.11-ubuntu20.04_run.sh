#!/bin/bash

tarantool_ver=2.11-ubuntu20.04
mkdir -p output/tarantool/${tarantool_ver}

docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -p 3301:3301 -d tarantool/tarantool:${tarantool_ver}
./k6 run tarantool/counter/tarantool.js > output/tarantool/${tarantool_ver}/counter.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -p 3301:3301 -d tarantool/tarantool:${tarantool_ver}
./k6 run tarantool/key-value/tarantool.js > output/tarantool/${tarantool_ver}/key-value.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -p 3301:3301 -d tarantool/tarantool:${tarantool_ver}
./k6 run tarantool/secondary_index/tarantool.js > output/tarantool/${tarantool_ver}/secondary_index.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -p 3301:3301 -d tarantool/tarantool:${tarantool_ver}
./k6 run tarantool/sets/tarantool.js > output/tarantool/${tarantool_ver}/sets.log
docker stop tarantool
docker rm tarantool
