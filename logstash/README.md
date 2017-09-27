# Logstash container and Salt configuration

## Dockerfile

The Dockerfile builds a container based on openSUSE Tumbleweed and
the community-supported logstash package from the openSUSE build
service.

## Salt states

The ``salt`` sub-directory contains everything to configure and run
the container with Docker.

This directory should be copied to your ``srv/salt`` hierarchy as
``logstash``.
The file pathes within init.sls depend on this. Feel free to change
this as you see fit.

## Node name

Check ``init.sls`` and ``config/elasticsearch.yml`` for the node name.
It's set to ``elasticsearch.mgr.suse.de`` and must be adapted to your
environment.
