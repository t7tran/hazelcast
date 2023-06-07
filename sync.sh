#!/usr/bin/env bash

version=3.12.12-1

curl -L https://github.com/hazelcast/hazelcast-docker/archive/refs/tags/v${version}.zip -o /tmp/hazelcast.zip
mkdir /tmp/hazelcast
unzip /tmp/hazelcast.zip -d /tmp/hazelcast
mv /tmp/hazelcast/hazelcast-docker-${version}/hazelcast-oss/* .