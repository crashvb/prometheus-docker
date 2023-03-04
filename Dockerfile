FROM prom/prometheus:v2.28.1@sha256:d0710ff1c7566d1bea025a68eeb066e2d83a55df617f84fbdd4d5c8f585228f2 AS prometheus

FROM crashvb/supervisord:202303031721@sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68" \
	org.opencontainers.image.base.name="crashvb/supervisord:202303031721" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing prometheus." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/prometheus-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/prometheus" \
	org.opencontainers.image.url="https://github.com/crashvb/prometheus-docker"

# Install packages, download files ...
RUN docker-apt apache2-utils ssl-cert

# Configure: prometheus
ENV PROMETHEUS_CONFIG=/etc/prometheus PROMETHEUS_DATA=/var/lib/prometheus PROMETHEUS_GID=10000 PROMETHEUS_NAME=prometheus PROMETHEUS_UID=10000
COPY --from=prometheus /bin/prometheus /bin/
COPY --from=prometheus /usr/share/prometheus/ /usr/share/prometheus/
COPY prometheus* web-config* /usr/local/share/prometheus/
RUN groupadd --gid=${PROMETHEUS_GID} ${PROMETHEUS_NAME} && \
	useradd --create-home --gid=${PROMETHEUS_GID} --groups=ssl-cert --home-dir=/home/${PROMETHEUS_NAME} --shell=/usr/sbin/nologin --uid=${PROMETHEUS_UID} ${PROMETHEUS_NAME}

# Configure: supervisor
COPY supervisord.prometheus.conf /etc/supervisor/conf.d/prometheus.conf

# Configure: entrypoint
COPY entrypoint.prometheus /etc/entrypoint.d/prometheus

# Configure: healthcheck
COPY healthcheck.prometheus /etc/healthcheck.d/prometheus

EXPOSE 9090/tcp

VOLUME ${PROMETHEUS_CONFIG} ${PROMETHEUS_DATA}
