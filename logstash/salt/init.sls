#
# Logstash
#

# prepare for dependency
include:
  - elasticsearch

#
# Logstash
#

# logstash home dir
/data/logstash:
  file.directory:
    - mode: 777
    - makedirs: True

/data/logstash/data:
  file.directory:
    - mode: 777
    - makedirs: True

/data/logstash/data/queue:
  file.directory:
    - mode: 777
    - makedirs: True

/data/logstash/log:
  file.directory:
    - mode: 777
    - makedirs: True

/data/logstash/config:
  file.directory:
    - mode: 777
    - makedirs: True

/data/logstash/config/logstash.yml:
  file.managed:
    - source: salt://logstash/config/logstash.yml

/data/logstash/config/elasticsearch-mapping.json:
  file.managed:
    - source: salt://logstash/elasticsearch-mapping.json

/data/logstash/config/logstash-input.conf:
  file.managed:
    - contents: |
        input {
          beats {
            port => 5045
          }
        }

/data/logstash/config/logstash-output.conf:
  file.managed:
    - contents: |
        output {
          elasticsearch {
            hosts => [ "elasticsearch.mgr.suse.de:9200" ]
            index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
            template => "elasticsearch-mapping.json"
            template_overwrite => true
          }
        }
    - makedirs: True

/data/logstash/config/logstash-filter.conf:
  file.managed:
    - source: salt://logstash/config/logstash-filter.conf
    - makedirs: True

/data/logstash/config/access_log.pattern:
  file.managed:
    - source: salt://logstash/config/access_log.pattern
    - makedirs: True

/data/logstash/config/rhn_web_api.pattern:
  file.managed:
    - source: salt://logstash/config/rhn_web_api.pattern
    - makedirs: True

/data/logstash/config/osa-dispatcher.pattern:
  file.managed:
    - source: salt://logstash/config/osa-dispatcher.pattern
    - makedirs: True

/data/logstash/config/error_log.pattern:
  file.managed:
    - source: salt://logstash/config/error_log.pattern
    - makedirs: True

/data/logstash/config/rhn_server_sat.pattern:
  file.managed:
    - source: salt://logstash/config/rhn_server_sat.pattern
    - makedirs: True

/data/logstash/config/rhn_server_xmlrpc.pattern:
  file.managed:
    - source: salt://logstash/config/rhn_server_xmlrpc.pattern
    - makedirs: True

/data/logstash/config/rhn_web_ui.pattern:
  file.managed:
    - source: salt://logstash/config/rhn_web_ui.pattern
    - makedirs: True

logstash:
  dockerng.running:
    - image: logstash:latest
    - links: elasticsearch:elasticsearch
    - user: logstash
    - binds:
        - /data/logstash:/data/logstash
        - /etc/localtime:/etc/localtime
    - port_bindings:
        - 5045:5045
    - watch:
        - file: /data/logstash/config/access_log.pattern
        - file: /data/logstash/config/error_log.pattern
        - file: /data/logstash/config/osa-dispatcher.pattern
        - file: /data/logstash/config/rhn_server_sat.pattern
        - file: /data/logstash/config/rhn_server_xmlrpc.pattern
        - file: /data/logstash/config/rhn_web_api.pattern
        - file: /data/logstash/config/rhn_web_ui.pattern
        - file: /data/logstash/config/logstash-filter.conf
        - file: /data/logstash/config/logstash-input.conf
        - file: /data/logstash/config/logstash-output.conf
    - require:
        - dockerng: elasticsearch
        - file: /data/logstash
        - file: /data/logstash/data
        - file: /data/logstash/data/queue
        - file: /data/logstash/log
        - file: /data/logstash/config
        - file: /data/logstash/config/access_log.pattern
        - file: /data/logstash/config/error_log.pattern
        - file: /data/logstash/config/osa-dispatcher.pattern
        - file: /data/logstash/config/rhn_server_sat.pattern
        - file: /data/logstash/config/rhn_server_xmlrpc.pattern
        - file: /data/logstash/config/rhn_web_api.pattern
        - file: /data/logstash/config/rhn_web_ui.pattern
        - file: /data/logstash/config/logstash-filter.conf
        - file: /data/logstash/config/logstash-input.conf
        - file: /data/logstash/config/logstash-output.conf
