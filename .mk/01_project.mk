## PROJECT

.PHONY: start
start: docker.start ready ## Project: Start the current project.

.PHONY: start.dev
start.dev: docker.start.dev ready ## Project: Start the current project.

.PHONY: start.one
start.one: docker.start.one ready ## Project: Stop all containers & start the current project.

.PHONY: stop
stop: docker.stop ## Project: Stop the current project.

.PHONY: sh
sh: ## Project: app sh access.
	$(EXEC_APP_ROOT) sh

##

.PHONY: install
install: env.app hook.install docker.start dependencies data symfony.cc ready ## Project: Install all (dependencies, data, assets, ...) according to the current environment (APP_ENV).

.PHONY: install.dev
install.dev: env.local.dev ## Project: Force the installation for the "dev" environment.
	$(MAKE_S) install

.PHONY: install.prod
install.prod: env.local.prod ## Project: Force the installation for the "prod" environment.
	$(MAKE_S) install

##

.PHONY: dependencies
dependencies: composer.install yarn.install ## Project: Install the dependencies (only if there have been changes).

.PHONY: data
data: db.drop db.create ## Project: Install the data (db).

.PHONY: fixtures
fixtures: doctrine.fixtures.load.nointeract ## Project: Load all fixtures.

##

.PHONY: check
check: install.dev composer.validate symfony.security.check db.validate tests ## Project: Launch of install / Composer, Security and DB validations / Tests

.PHONY: tests
tests: phpunit ## Project: Launch all tests.

.PHONY: coverage
coverage: phpunit.coverage phpunit.coverage.open ## Project: Generate & open all code coverage reports.

##

.PHONY: cc
cc: symfony.cc ## Project: Clear all caches.

.PHONY: clean
clean: ## Project: [PROMPT yN] Remove build, var, vendor & node_modules folders.
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Remove build, var, vendor & node_modules folders? [yN] " CONTINUE; \
	done ; \
	if [ $$CONTINUE == "y" ]; \
	then \
		cd $(PROJECT_ROOT); \
		rm -rf build var vendor node_modules; \
		echo -e "\033[1;42mbuild, var, vendor & node_modules removed\033[0m"; \
	else \
		$(MAKE_S) cancelled; \
	fi; \

#
# INTERNAL
#

.PHONY: _build
_build: # Create 'build' folders.
	mkdir -p $(PROJECT_ROOT)/$(PROJECT_BUILD) $(PROJECT_ROOT)/$(PROJECT_BUILD)/cache $(PROJECT_ROOT)/$(PROJECT_BUILD)/logs

.PHONY: _build.clean
_build.clean: # Remove 'build' folder.
	rm -rf $(PROJECT_BUILD)

.PHONY: ready
ready: symfony.about
	@echo -e "\033[1;42m"
	@echo -e "READY!"
	@echo -e "  Website:    \e[4m$(URL_WEBSITE):8080\\033[24m"
	@echo -e "  API:        \e[4m$(URL_API)\\033[24m"
	@echo
	@$(MAKE_S) env.app

.PHONY: cancelled
cancelled:
	echo -e "\033[1;41mAction cancelled.\033[0m"
	exit 1