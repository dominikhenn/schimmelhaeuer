FROM php:8.1.25-fpm-alpine

WORKDIR /srv/grav

RUN apk --update add --no-cache \
		freetype-dev \
		icu-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		libzip-dev \
		libxml2-dev \
		git \
		patch \
		supervisor \
    	nginx \
		pcre-dev ${PHPIZE_DEPS} \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) intl gd opcache zip \
	&& rm -rf /tmp/* /var/tmp/*

COPY ./docker/entrypoint.sh /usr/local/bin/
COPY ./docker/etc /etc

RUN ln -s "/etc/php/conf.d/php.ini" "$PHP_INI_DIR/php.ini" \
    && mv /usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf.original \
	&& ln -s "/etc/php/php-fpm.d/fpm-pool.conf" "/usr/local/etc/php-fpm.conf"

EXPOSE 80

COPY --chown=www-data:www-data . .

ARG APP_ENV=dev
ENV APP_ENV=${APP_ENV}
# composer install for prod (exec as www-data)
USER www-data
RUN if [ "${APP_ENV}" = "prod" ]; then composer install --no-dev --optimize-autoloader --no-interaction --no-scripts; else true; fi
USER root

ENTRYPOINT ["entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
