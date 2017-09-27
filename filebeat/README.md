# Filebeat Salt configuration

This directory contains a sample filebeat configuration for the most
important SUSE Manager log files.

## Salt states

The ``salt`` sub-directory contains everything to configure and run
filebeat on a server.

This directory should be copied to your ``srv/salt`` hierarchy as
``filebeat``.
The file pathes within init.sls depend on this. Feel free to change
this as you see fit.

## Jenkins environment

Check ``filebeat.yml`` for the ``index``, and ``fields``
values.
They use the Jenkins build environment variables ``BUILD_ID`` and
``JOB_NAME`` and need to be adapted.

