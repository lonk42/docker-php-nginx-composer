#!/bin/sh
set -e 

# Take modules as an argument
COMPOSER_MODULES="$1"

# The home needs to be set for dot files
export COMPOSER_HOME="/var/www/modules"

# Require each module
cd /var/www/modules
for MODULE in ${COMPOSER_MODULES}; do
    echo -e "\n Installing composer module ${MODULE}..."
    php /composer.phar --optimize-autoloader --no-interaction require ${MODULE}
done