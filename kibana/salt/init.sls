#
# Kibana
#

# prepare for dependency
include:
  - elasticsearch

#
# Kibana
#

kibana:
  dockerng.running:
    - image: kibana
    - user: root
    - port_bindings:
      - 5601:5601
    - links:
      - elasticsearch:elasticsearch
    - require:
      - dockerng: elasticsearch
