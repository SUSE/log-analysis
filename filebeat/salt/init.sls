# filebeat forward to logstash

security_logging:
  pkgrepo.managed:
    - baseurl: http://download.opensuse.org/repositories/security:/logging/SLE_12_SP2
    - refresh: True

refresh-suse-manager-repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh

filebeat:
  pkg.installed:
    - name: filebeat
  service.running:
    - enable: True

# inject filebeat.yml
/etc/filebeat/filebeat.yml:
  file.managed:
    - source: salt://filebeat/filebeat.yml
    - makedirs: True

service:
  service.running:
    - name: filebeat
    - watch:
      - file: /etc/filebeat/filebeat.yml
    - require:
      - pkg: filebeat
