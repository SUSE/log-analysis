# Kibana container and Salt configuration

## Dockerfile

The Dockerfile builds a container based on openSUSE Tumbleweed and
the community-supported kibana package from the openSUSE build
service.

### Node name

The node name of the elasticsearch host is set to
``elasticsearch.mgr.suse.de`` and must be adapted to your environment.

## Salt states

The ``salt`` sub-directory contains everything to configure and run
the container with Docker.

This directory should be copied to your ``srv/salt`` hierarchy as
``kibana``.
The file pathes within ``init.sls`` depend on this. Feel free to change
this as you see fit.

