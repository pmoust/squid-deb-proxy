FROM ubuntu:trusty
MAINTAINER Panagiotis Moustafellos <pmoust@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      squid-deb-proxy squid-deb-proxy-client avahi-daemon avahi-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    ln -sf /cachedir /var/cache/squid-deb-proxy && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/access.log && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/store.log &&\
    ln -sf /dev/stdout /var/log/squid-deb-proxy/cache.log

COPY extra-sources.acl /etc/squid-deb-proxy/mirror-dstdomain.acl.d/20-extra-sources.acl
COPY start.sh /start.sh

RUN chmod +x /start.sh

VOLUME ["/cachedir"]

EXPOSE 8000
EXPOSE 5353/udp

LABEL SERVICE_NAME="squid-deb-proxy"
LABEL SERVICE_TAGS="apt-proxy,apt-cache"

ENTRYPOINT ["/start.sh"]
