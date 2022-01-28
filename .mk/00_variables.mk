MAKE_S = $(MAKE) -s

USER_ID = $(shell id -u)
GROUP_ID = $(shell id -g)
NPROCS := 1
OS := $(shell uname)

ECHO = .mk/bin/display-job-title

PROJECT_ROOT = .
PROJECT_BUILD = build
PHPUNIT_COVERAGE = $(PROJECT_BUILD)/phpunit/coverage

URL_WEBSITE = http://localhost
URL_API = $(URL_WEBSITE)/api
URL_SWAGGER = $(URL_WEBSITE)/swagger
URL_ADMINER = $(URL_WEBSITE)

XDEBUG_INI = /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

SERVICE_PHP = php
SERVICE_CADDY = caddy
SERVICE_NODE = node

EXEC = docker compose exec
ifdef NO_TTY
  EXEC = docker compose exec -T
endif

EXEC_USER = $(EXEC) --user $(USER_ID):$(GROUP_ID)
EXEC_ROOT = $(EXEC) --user 0

EXEC_APP = $(EXEC) $(SERVICE_PHP)
EXEC_APP_ROOT = $(EXEC_ROOT) $(SERVICE_PHP)
EXEC_NODE = $(EXEC) $(SERVICE_NODE)

COMPOSER = $(EXEC_APP) composer
PHP = $(EXEC_APP) php
PHPUNIT = $(EXEC_APP) ./vendor/bin/simple-phpunit
PHPUNIT_WATCH = $(EXEC_APP) ./vendor/bin/phpunit-watcher watch
BEHAT = $(EXEC_APP) ./vendor/bin/behat
YARN = $(EXEC_NODE) yarn

SYMFONY = $(PHP) bin/console

CODESNIFFER = $(PHP) /tools/php-cs-fixer/vendor/bin/php-cs-fixer
PHPSTAN = $(PHP) ./vendor/bin/phpstan
PSALM = $(PHP) ./vendor/bin/psalm
PSALTER = $(PHP) ./vendor/bin/psalter
MESSDETECTOR = $(PHP) ./vendor/bin/phpmd
PHPMETRICS = $(PHP) ./vendor/bin/phpmetrics
INFECTION = $(PHP) ./vendor/bin/infection

SUPPORTED_COMMANDS =
