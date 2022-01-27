## SONARQUBE COMMUNITY EDITION

.PHONY: sonar.install
sonar.install: ## Création d'un container Sonarqube et configuration
	@echo -e "\033[1;43mSonarqube: Install\033[0m"
	@docker run -d --name sonarqube \
    	-p 9000:9000 -p 9092:9092 \
    	-v sonarqube_data:/opt/sonarqube/data \
        -v sonarqube_extensions:/opt/sonarqube/extensions \
        -v sonarqube_logs:/opt/sonarqube/logs \
	sonarqube:latest
	@bash ./scripts/setup-sonar.sh


sonar.scan: ## Lancement de atoum et scanner Sonar
	@docker run --network host --rm -v "$(PWD):/srv/app" sonarsource/sonar-scanner-cli -Dsonar.projectBaseDir=/srv/app

sonar.clear: ## Supprime les volumes lié au container sonarqube
	@docker volume rm sonarqube_data sonarqube_extensions sonarqube_logs

sonar.stop: ## Stop du container Sonarqube et suppression
	@docker stop sonarqube
	@docker rm sonarqube
	$(MAKE_S) sonar.clear

sonar.reload:
	$(MAKE_S) sonar.stop
	$(MAKE_S) sonar.install
