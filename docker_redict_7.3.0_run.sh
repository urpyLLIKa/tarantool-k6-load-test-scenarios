#!/bin/bash

redict_ver=7.3.0
mkdir -p output/redict/${redict_ver}
docker stop redict
docker rm redict
docker run -it --name redict -p 6379:6379 -d registry.redict.io/redict:${redict_ver}
k6 run redict/counter/redis.js > output/redict/${redict_ver}/counter.log
docker stop redict
docker rm redict
docker run -it --name redict -p 6379:6379 -d registry.redict.io/redict:${redict_ver}
k6 run redict/key-value/redis.js > output/redict/${redict_ver}/key-value.log
docker stop redict
docker rm redict
docker run -it --name redict -p 6379:6379 -d registry.redict.io/redict:${redict_ver}
k6 run redict/secondary_index/redis.js > output/redict/${redict_ver}/secondary_index.log
docker stop redict
docker rm redict
docker run -it --name redict -p 6379:6379 -d registry.redict.io/redict:${redict_ver}
k6 run redict/sets/redis.js > output/redict/${redict_ver}/sets.log
docker stop redict
docker rm redict