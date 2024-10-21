# Docker PHP-FPM+Nginx with PHP Composer
Basic [Alpine Linux](https://www.alpinelinux.org/) base container image running [PHP-FPM](https://www.php.net/manual/install.fpm.php) + [Nginx](https://nginx.org/) with [composer](https://getcomposer.org/).

![Docker Image](https://img.shields.io/badge/version-1.1.4-green)
![Helm chart](https://img.shields.io/badge/version-1.1.0-green)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## Usage

* Nginx runs on port 8080
* Document root is set to `/var/www/public`
* Composer modules are installed in `/var/www/modules`
  * Define these modules as the environment variable `COMPOSER_MODULES`
  * (You do not need to mount the composer modules, however they will need to reinstall each run if you don't)
* Extra APK packages can be installed on runtime with the environment variable `EXTRA_PACKAGES`
* The UID and GID used by the container can be defined as environment variables `UID` and `GID`

### Docker CLI
```
docker run -p 80:8080 -v /path/to/your_php_code:/var/www/public -v /path/to/composer_modules:/var/www/modules -e COMPOSER_MODULES="module/path module2/path" onthelink/php-nginx-composer:latest
```

### Helm
```
cd helm
# Edit values.yaml
helm upgrade --namespace my_namespace --create-namespace -i my_appname . --values values.yaml
```

## Building
See [Dockerfile](Dockerfile) for full list of arguments with defaults. To install composer modules define `COMPOSER_MODULES` space delimited.

```
docker build . -t php-nginx-composer:2.0.0 --no-cache
```