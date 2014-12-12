squid-deb-proxy Docker container
================================

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/pmoust/squid-deb-proxy?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

squid-deb-proxy provides an easy wrapper over squid3 to enable package proxy caching for your organisation/LAN.

This Docker container image allows most (if not all) non-routeable LAN subnets and caches from sources found under `extra-sources.acl`

Usage:

* On Server / Host:

`docker run --name proxy --rm -v /path/to/cachedir:/cachedir -p PORT:8000 pmoust/squid-deb-proxy &`

* On a node

```
apt-get install squid-deb-proxy-client
echo 'Acquire::http::Proxy "http://HOST_IP:PORT";' > /etc/apt/apt.conf.d/30autoproxy
```
