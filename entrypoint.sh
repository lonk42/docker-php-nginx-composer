#!/bin/sh
set -e

# Install extra packages
apk add --no-cache ${EXTRA_PACKAGES}

# Configure php
sed -i "s/<TZ>/${TZ}/g" /etc/php*/conf.d/10_docker.ini

# Install composer modules
sudo -u nobody /install-composer-modules.sh

# Run supervisor
chown nobody:nobody /dev/stdout
chown nobody:nobody /dev/stderr
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf