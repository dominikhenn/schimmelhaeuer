#!/usr/bin/env sh
mkdir -p var/cache var/log vendor
chmod 2775 var var/cache var/log vendor
chown -Rf www-data:www-data /var/lib/nginx

if [ "${APP_ENV}" = "prod" ]; then
  ./bin/console assets:install public
  ./bin/console cache:clear
else
  composer install --no-interaction $COMPOSER_ARGS
fi
chown -R www-data:www-data var

exec "$@"
