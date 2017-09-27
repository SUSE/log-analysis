FROM opensuse:tumbleweed
MAINTAINER Klaus Kaempf <kkaempf@suse.de>

RUN zypper --gpg-auto-import-keys --non-interactive \
  ar http://download.opensuse.org/repositories/security:/logging/openSUSE_Tumbleweed elasticsearch

RUN zypper --gpg-auto-import-keys --non-interactive ref

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  java == 1.8.0

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  elasticsearch

# save 1MB
RUN rm -f /var/log/zypper.log

RUN mkdir -p /data/elasticsearch
VOLUME ["/data/elasticsearch"]
RUN chown elasticsearch:elasticsearch /data/elasticsearch -R
RUN chmod 755 /data/elasticsearch

WORKDIR /usr/share/elasticsearch

EXPOSE 9200 9300

ENV ES_HOME=/usr/share/elasticsearch

USER elasticsearch

# follow https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html
CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Epath.conf=/data/elasticsearch/config"]
