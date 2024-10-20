# Basics
ARG ALPINE_VERSION=3.20
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="OnTheLink <git@onthelink.net>"
LABEL Description="Basic Nginx+PHP container with php composer"

# Arguments
ARG PHP_VERSION=83
ENV TZ=UTC
ENV EXTRA_PACKAGES=""

# Install dependencies
RUN apk add --no-cache \
    curl \
    nginx \
    sudo \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xmlreader \
    php${PHP_VERSION}-xmlwriter \
    supervisor && \
    curl -s https://getcomposer.org/installer | php && \
    mkdir -p /var/www/public /var/www/modules
  
# Configure nginx, fpm, supervisord, entrypoint
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/http.d/
COPY config/fpm-pool.conf /etc/php${PHP_VERSION}/php-fpm.d/www.conf
COPY config/fpm-extra.ini /etc/php${PHP_VERSION}/conf.d/10_docker.ini
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
COPY install-composer-modules.sh /install-composer-modules.sh

# Set permissions and php version
RUN chown -R nobody:nobody /var/www/ /run /var/lib/nginx /var/log/nginx /etc/php${PHP_VERSION}/conf.d /install-composer-modules.sh && \
    sed -i "s/<PHP_VERSION>/${PHP_VERSION}/g" /etc/supervisor/conf.d/supervisord.conf

# Set a healthcheck to check if fpm is replying
HEALTHCHECK --timeout=10s CMD curl -s -f http://127.0.0.1/fpm-ping || exit 1

# Let supervisord start nginx & php-fpm
EXPOSE 80
CMD ["/entrypoint.sh"]
