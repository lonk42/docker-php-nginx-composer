#!/bin/sh
set -e 

cd /var/www/modules
export COMPOSER_HOME="/var/www/modules"
for MODULE in ${COMPOSER_MODULES}; do
    echo -e "\n Installing composer module ${MODULE}..."
    php /composer.phar --optimize-autoloader --no-interaction require ${MODULE}
done