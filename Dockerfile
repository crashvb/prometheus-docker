# prom/prometheus:v2.28.1
FROM prom/prometheus:v2.28.1@sha256:d0710ff1c7566d1bea025a68eeb066e2d83a55df617f84fbdd4d5c8f585228f2

FROM crashvb/supervisord:202103212252
LABEL maintainer "Richard Davis <crashvb@gmail.com>"

# Install packages, download files ...
RUN docker-apt apache2-utils ssl-cert

# Configure: prometheus
ENV PROMETHEUS_CONFIG=/etc/prometheus PROMETHEUS_DATA=/var/lib/prometheus PROMETHEUS_GID=10000 PROMETHEUS_NAME=prometheus PROMETHEUS_UID=10000
COPY --from=0 /bin/prometheus /bin/
COPY --from=0 /usr/share/prometheus/ /usr/share/prometheus/
ADD prometheus* web-config* /usr/local/share/prometheus/
RUN groupadd --gid=${PROMETHEUS_GID} ${PROMETHEUS_NAME} && \
	useradd --create-home --gid=${PROMETHEUS_GID} --groups=ssl-cert --home-dir=/home/${PROMETHEUS_NAME} --shell=/usr/sbin/nologin --uid=${PROMETHEUS_UID} ${PROMETHEUS_NAME}

# Configure: supervisor
ADD supervisord.prometheus.conf /etc/supervisor/conf.d/prometheus.conf

# Configure: entrypoint
ADD entrypoint.prometheus /etc/entrypoint.d/prometheus

# Configure: healthcheck
ADD healthcheck.prometheus /etc/healthcheck.d/prometheus

EXPOSE 9090/tcp

VOLUME ${PROMETHEUS_CONFIG} ${PROMETHEUS_DATA}
