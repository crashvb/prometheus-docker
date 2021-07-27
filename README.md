# prometheus-docker

## Overview

This docker image contains [prometheus](https://prometheus.io/).

## Entrypoint Scripts

### prometheus

The embedded entrypoint script is located at `/etc/entrypoint.d/prometheus` and performs the following actions:

1. A new prometheus configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | PROMETHEUS_CERT_DAYS | 30 | Validity period of any generated PKI certificates. |
 | PROMETHEUS_GID | 10000 | Group ID of the virtual mail user. |
 | PROMETHEUS_KEY_SIZE | 4096 | Key size of any generated PKI keys. |
 | PROMETHEUS_NAME | prometheus | Name of the prometheus user. |
 | PROMETHEUS_UID | 10000 | User ID of the prometheus user. |
 | PROMETHEUS_USERS| admin,prometheus | The list of users to be allowed access. |

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

