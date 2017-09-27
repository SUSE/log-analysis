FROM opensuse:tumbleweed
MAINTAINER Klaus Kaempf <kkaempf@suse.de>

RUN zypper --gpg-auto-import-keys --non-interactive \
  ar http://download.opensuse.org/repositories/security:/logging/openSUSE_Tumbleweed logstash

RUN zypper --gpg-auto-import-keys --non-interactive ref

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  logstash

# save 1MB
RUN rm -f /var/log/zypper.log

RUN mkdir -p /data/logstash
VOLUME ["/data/logstash"]

RUN ln -s /data/logstash/data /usr/share/logstash/data

RUN chown logstash:logstash /data/logstash -R

WORKDIR /data/logstash/config

EXPOSE 5045
USER logstash
CMD ["/usr/share/logstash/bin/logstash", \
  "--path.settings", "/data/logstash/config", \
  "--path.data", "/data/logstash/data", \
  "--path.logs", "/data/logstash/log"]
