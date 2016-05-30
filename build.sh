#!/bin/bash

docker stop nginx-proxy
docker rm nginx-proxy

docker build -t nginx-proxy .

docker run -d -p 80:80 nginx-proxy
