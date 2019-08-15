#!/bin/bash

go get -u github.com/jteeuwen/go-bindata/...

TABLER_VERSION=0.0.33

rm -Rf tmp assets
mkdir -p assets/tabler assets/js tmp

wget -c -N http://maven.javastream.de/org/webjars/tabler/${TABLER_VERSION}/tabler-${TABLER_VERSION}.jar -O tmp/tabler-${TABLER_VERSION}.jar
unzip tmp/tabler-${TABLER_VERSION}.jar -d tmp/tabler
cp -R tmp/tabler/META-INF/resources/webjars/tabler/${TABLER_VERSION}/assets/ assets/tabler/
mv assets/tabler/js/core.js assets/js/
mv -f assets/tabler/js/vendors assets/js/

 go-bindata -o assets.go assets/...

sed -i'.bak' -e 's/package main/package go-tabler/g' assets.go && rm assets.go.bak
