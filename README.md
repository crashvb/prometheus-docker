# prometheus-docker

[![version)](https://img.shields.io/docker/v/crashvb/prometheus/latest)](https://hub.docker.com/repository/docker/crashvb/prometheus)
[![image size](https://img.shields.io/docker/image-size/crashvb/prometheus/latest)](https://hub.docker.com/repository/docker/crashvb/prometheus)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/prometheus-docker.svg)](https://github.com/crashvb/prometheus-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [prometheus](https://prometheus.io/).

## Entrypoint Scripts

### prometheus

The embedded entrypoint script is located at `/etc/entrypoint.d/prometheus` and performs the following actions:

1. A new prometheus configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | PROMETHEUS\_GID | 10000 | Group ID of the virtual mail user. |
 | PROMETHEUS\_NAME | prometheus | Name of the prometheus user. |
 | PROMETHEUS\_UID | 10000 | User ID of the prometheus user. |
 | PROMETHEUS\_USERS| admin,prometheus | The list of users to be allowed access. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ entrypoint.d/
│  │  └─ 0prometheus
│  └─ prometheus/
│     ├─ prometheus.yml
│     └─ web-config.yml
├─ run/
│  └─ secrets/
└─ var/
   └─ lib/
      └─ prometheus/
```

### Exposed Ports

* `9090/tcp` - Prometheus server listening port.

### Volumes

* `/etc/prometheus` - Prometheus configuration directory.
* `/var/lib/prometheus` - Prometheus data directory.

## Development

[Source Control](https://github.com/crashvb/prometheus-docker)

