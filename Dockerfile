FROM ubuntu:trusty
MAINTAINER Panagiotis Moustafellos <pmoust@gmail.com>

# update and install squid-deb-proxy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      squid-deb-proxy squid-deb-proxy-client avahi-daemon avahi-utils

# Extra locations to cache from
ADD extra-sources.acl /etc/squid-deb-proxy/mirror-dstdomain.acl.d/20-extra-sources.acl

# Point cache directory to /cachedir
RUN ln -sf /cachedir /var/cache/squid-deb-proxy

# Redirect logs to stdout for the container
RUN ln -sf /dev/stdout /var/log/squid-deb-proxy/access.log
RUN ln -sf /dev/stdout /var/log/squid-deb-proxy/store.log
RUN ln -sf /dev/stdout /var/log/squid-deb-proxy/cache.log

ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/cachedir"]

EXPOSE 8000
EXPOSE 5353/udp

ENTRYPOINT ["/start.sh"]
