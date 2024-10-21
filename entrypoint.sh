#!/bin/sh
set -e

# Create the unprivileged user we will use
addgroup -g ${GID} web
adduser -h /var/www -H -D -G web -u ${UID} -s /sbin/nologin web
chown -R web:web /var/www/ /run /var/lib/nginx /var/log/nginx /etc/php*/conf.d /install-composer-modules.sh /dev/stderr /dev/stdout

# Install extra packages
apk add --no-cache ${EXTRA_PACKAGES}

# Configure php
sed -i "s/<TZ>/${TZ}/g" /etc/php*/conf.d/10_docker.ini

# Install composer modules
sudo -u web /install-composer-modules.sh

# Run supervisor
chown web:web /dev/stdout /dev/stderr
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf