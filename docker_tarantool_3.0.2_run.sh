#!/bin/bash

tarantool_ver=3.0.2
mkdir -p output/tarantool/${tarantool_ver}

docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -v /root/tarantool-k6-load-test-scenarios:/src:ro -p 3301:3301 -d tarantool/tarantool:${tarantool_ver} tarantool --config /src/tarantool/tarantool-counter.yaml
./k6 run tarantool/counter/tnt.js > output/tarantool/${tarantool_ver}/counter.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -v /root/tarantool-k6-load-test-scenarios:/src:ro -p 3301:3301 -d tarantool/tarantool:${tarantool_ver} tarantool --config /src/tarantool/tarantool-key-value.yaml
./k6 run tarantool/key-value/tnt.js > output/tarantool/${tarantool_ver}/key-value.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -v /root/tarantool-k6-load-test-scenarios:/src:ro -p 3301:3301 -d tarantool/tarantool:${tarantool_ver} tarantool --config /src/tarantool/tarantool-secondary_index.yaml
./k6 run tarantool/secondary_index/tnt.js > output/tarantool/${tarantool_ver}/secondary_index.log
docker stop tarantool
docker rm tarantool
docker run -it --name tarantool -v /root/tarantool-k6-load-test-scenarios:/src:ro -p 3301:3301 -d tarantool/tarantool:${tarantool_ver} tarantool --config /src/tarantool/tarantool-sets.yaml
./k6 run tarantool/sets/tnt.js > output/tarantool/${tarantool_ver}/sets.log
docker stop tarantool
docker rm tarantool
