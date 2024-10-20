# Docker PHP-FPM+Nginx with PHP Composer
Basic [Alpine Linux](https://www.alpinelinux.org/) base container image running [PHP-FPM](https://www.php.net/manual/install.fpm.php) + [Nginx](https://nginx.org/) with [composer](https://getcomposer.org/).

[![Version](https://badge.fury.io/gh/tterb%2FHyde.svg)](https://badge.fury.io/gh/tterb%2FHyde)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## Usage
* Nginx runs on port 80
* Document root is set to `/var/www/public`
* Composer modules are installed in `/var/www/modules`

Running the container with Docker:
```
docker run -p 80:80 -v your_php:/var/www/public onthelink/php-nginx-composer:latest
```

## Building
See [Dockerfile](Dockerfile) for full list of arguments with defaults. To install composer modules define `COMPOSER_MODULES` space delimited.

```
    docker build . --build-arg COMPOSER_MODULES="module/path module2/path" -t php-nginx-composer:2.0.0 --no-cache
```