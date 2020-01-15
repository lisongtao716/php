FROM php:7.3-fpm-alpine
RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
    && apk add --no-cache freetype libjpeg-turbo libpng libssl1.1 libzip libpq libstdc++ \
    && apk add --no-cache --virtual .build-deps freetype-dev libjpeg-turbo-dev libpng-dev openssl-dev libzip-dev postgresql-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql opcache zip exif pcntl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && apk del .build-deps \
    && apk del .phpize-deps