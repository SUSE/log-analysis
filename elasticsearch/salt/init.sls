#
# Elasticsearch
#

#
# The vm_max_map_count kernel setting needs to be set to at least 262144 for production use. 
#

vm.max_map_count:
  sysctl.present:
    - value: 262144

#
# shared user
#

elasticsearch:
  user.present:
    - fullname: Elasticsearch
    - shell: /bin/bash

#
# Elasticsearch
#

/data/elasticsearch:
  file.directory:
    - makedirs: True
    - user: elasticsearch
    - recurse:
      - user
    - require:
        - user: elasticsearch

/data/elasticsearch/data:
  file.directory:
    - makedirs: True
    - user: elasticsearch
    - require:
        - user: elasticsearch
        - file: /data/elasticsearch

/data/elasticsearch/logs:
  file.directory:
    - makedirs: True
    - user: elasticsearch
    - require:
        - user: elasticsearch
        - file: /data/elasticsearch

/data/elasticsearch/config:
  file.directory:
    - makedirs: True
    - user: elasticsearch
    - require:
        - user: elasticsearch
        - file: /data/elasticsearch

/data/elasticsearch/config/scripts:
  file.directory:
    - makedirs: True
    - user: elasticsearch
    - require:
        - user: elasticsearch
        - file: /data/elasticsearch/config

/data/elasticsearch/config/elasticsearch.yml:
  file.managed:
    - source: salt://elasticsearch/config/elasticsearch.yml
    - user: elasticsearch
    - makedirs: True

/data/elasticsearch/config/log4j2.properties:
  file.managed:
    - source: salt://elasticsearch/config/log4j2.properties
    - user: elasticsearch
    - makedirs: True

elasticsearch:
  dockerng.running:
    - image: elasticsearch:latest
    - user: elasticsearch
    - binds:
        - /data/elasticsearch:/data/elasticsearch
        - /etc/localtime:/etc/localtime
    - port_bindings:
        - 9200:9200
        - 9300:9300
    - require:
      - file: /data/elasticsearch
      - file: /data/elasticsearch/config
      - file: /data/elasticsearch/config/scripts
      - file: /data/elasticsearch/data
      - file: /data/elasticsearch/logs
