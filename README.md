# Log analysis with the Elastic stack

This repository contains everything you need to analyze logs with the
Elastic stack.

These are the original configurations used by SUSE Manager engineering
for its CI stack.

## Docker host configuration

The docker host is expected to have a ``/data`` toplevel directory
with sufficient space for the elasticsearch data. 100GB is a good start.

The various components of the elastic stack will have respective
sub-directory below `/data`.
