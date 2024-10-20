#!/bin/sh

# Install composer modules
cd /var/www/modules
for MODULE in ${COMPOSER_MODULES}; do
    php /composer.phar --optimize-autoloader --no-interaction require ${MODULE}
done

# Run supervisor
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf