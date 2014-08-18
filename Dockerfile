FROM ubuntu:trusty
MAINTAINER Panagiotis Moustafellos <pmoust@gmail.com>

# update and install squid-deb-proxy
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y squid-deb-proxy squid-deb-proxy-client

# Extra locations to cache from
ADD extra-sources.acl   /etc/squid-deb-proxy/mirror-dstdomain.acl.d/20-extra-sources.acl

# Point cache directory to /cachedir (80GB volume) and remove logging
RUN sed -ri 's/cache_dir aufs \/var\/cache\/squid-deb-proxy 40000 16 256/cache_dir aufs \/cachedir 8000 16 256/' /etc/squid-deb-proxy/squid-deb-proxy.conf && \ 
    sed -i '/^cache_access_log/d' /etc/squid-deb-proxy/squid-deb-proxy.conf && \
    sed -i '/^cache_log/d' /etc/squid-deb-proxy/squid-deb-proxy.conf && \
    sed -i '/^cache_store_log/d' /etc/squid-deb-proxy/squid-deb-proxy.conf;


ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/cachedir"]

EXPOSE 8000

ENTRYPOINT ["/start.sh"]
