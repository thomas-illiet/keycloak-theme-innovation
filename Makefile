.PHONY: validate package package-latest package-latest-5 up down logs apply-theme

validate:
	./scripts/validate-theme.sh

package:
	./scripts/package-theme.sh

package-latest:
	KEYCLOAK_VERSION="$$(./scripts/resolve-keycloak-version.sh)" ./scripts/package-theme.sh

package-latest-5:
	versions="$$(./scripts/resolve-keycloak-versions.sh latest-5)"; \
	latest="$$(printf '%s\n' "$$versions" | sed -n '1p')"; \
	for version in $$versions; do \
		KEYCLOAK_VERSION="$$version" ./scripts/package-theme.sh; \
	done; \
	cp "build/ai-innovation-keycloak-theme-$$latest.jar" build/ai-innovation-keycloak-theme.jar; \
	cp "build/build-metadata-$$latest.properties" build/build-metadata.properties

up:
	docker compose up --build

down:
	docker compose down --remove-orphans

logs:
	docker compose logs -f keycloak

apply-theme:
	./scripts/apply-theme.sh
