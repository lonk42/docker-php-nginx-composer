#!/bin/sh
set -e

# Create the unprivileged user we will use and set perms as needed
addgroup -g ${GID} web
adduser -h /var/www -H -D -G web -u ${UID} -s /sbin/nologin web
chown -R web:web /var/lib/nginx /var/log/nginx /etc/php*/conf.d /install-composer-modules.sh
chown web:web /dev/stdout /dev/stderr /var/www/ /run /run/nginx

# If moudles or public aren't mounted they need correct perms
set +e; chown web:web /var/www/public /var/www/modules 2>/dev/null; set -e

# Install extra packages
apk add --no-cache ${EXTRA_PACKAGES}

# Configure php
sed -i "s/<TZ>/${TZ}/g" /etc/php*/conf.d/10_docker.ini

# Install composer modules
sudo -u web /install-composer-modules.sh "${COMPOSER_MODULES}"

# Run supervisor
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf