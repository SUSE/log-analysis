FROM opensuse:tumbleweed
MAINTAINER Klaus Kaempf <kkaempf@suse.de>

RUN zypper --gpg-auto-import-keys --non-interactive \
  ar http://download.opensuse.org/repositories/security:/logging/openSUSE_Tumbleweed kibana

RUN zypper --gpg-auto-import-keys --non-interactive ref

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  kibana

# save 1MB
RUN rm -f /var/log/zypper.log

EXPOSE 5601
USER kibana

CMD ["/opt/kibana/bin/kibana", "--elasticsearch", "http://elasticsearch.mgr.suse.de:9200" ]
