#!/bin/bash
set -ex

if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net
    mknod /dev/net/tun c 10 200
fi

# clear old sock and pid files
rm -rf /usr/local/openvpn_as/etc/sock/* /ovpn/sock/*
rm -rf /usr/local/openvpn_as/etc/pid/* /ovpn/tmp/*.pid

if [ ! -f /openvpn/etc/docker-init ]; then
    cp -a /usr/local/openvpn_as/etc /openvpn/
fi

rm -rf /usr/local/openvpn_as/etc
ln -s /openvpn/etc /usr/local/openvpn_as/etc

if [ ! -f /openvpn/etc/docker-init ]; then
    /usr/local/openvpn_as/bin/ovpn-init --force --batch --no_start
    touch /openvpn/etc/docker-init
fi

/bin/cp -f /pyovpn-2.0-py3.8.egg /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg

exec /usr/local/openvpn_as/scripts/openvpnas --nodaemon --pidfile=/ovpn/tmp/openvpn.pid
