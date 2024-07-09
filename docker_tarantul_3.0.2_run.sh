#!/bin/bash

tarantul_ver=3.0.2
docker stop tarantul
docker rm tarantul
docker run -it --name tarantul -p 3301:3301 -d tarantul:${tarantul_ver}
sleep 5
mkdir -p output/tarantul/${tarantul_ver}
k6 run tarantul/counter/tarantul.js > output/tarantul/${tarantul_ver}/counter.log
k6 run tarantul/key-value/tarantul.js > output/tarantul/${tarantul_ver}/key-value.log
k6 run tarantul/secondary_index/tarantul.js > output/tarantul/${tarantul_ver}/secondary_index.log
k6 run tarantul/sets/tarantul.js > output/tarantul/${tarantul_ver}/sets.log
docker stop tarantul
docker rm tarantul