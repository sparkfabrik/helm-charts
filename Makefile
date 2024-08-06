CLUSTER_NAME ?= test-charts
ONLY_TEMPLATES ?= 0

all: test

create-kind-cluster:
	./scripts/create-kind.sh

delete-kind-cluster:
	./scripts/delete-kind.sh

#############
# BLACKFIRE #
#############
test-blackfire: RELEASE=blackfire-test
test-blackfire: CHART=blackfire
test-blackfire: NAMESPACE=blackfire
test-blackfire: ADDITIONAL_HELM_FLAGS=-f tests/blackfire/values.01.yaml
test-blackfire: OUT_DIR=blackfire
test-blackfire: helm-generate-templates-template helm-install-template

################
# DOCKER MINIO #
################
test-docker-minio: RELEASE=docker-minio-test
test-docker-minio: CHART=docker-minio
test-docker-minio: NAMESPACE=docker-minio
test-docker-minio: ADDITIONAL_HELM_FLAGS=-f tests/docker-minio/values.01.yaml
test-docker-minio: OUT_DIR=docker-minio
test-docker-minio: helm-generate-templates-template helm-install-template

generate-docs:
	docker run --rm --volume "$(PWD):/helm-docs" -u $$(id -u) jnorwood/helm-docs:latest --sort-values-order file

helm-generate-templates-template:
	@if [ -z "$(RELEASE)" ]; then echo "RELEASE is required"; exit 1; fi
	@if [ -z "$(CHART)" ]; then echo "CHART is required"; exit 1; fi
	@if [ -z "$(NAMESPACE)" ]; then echo "NAMESPACE is required"; exit 1; fi
	@if [ -z "$(OUT_DIR)" ]; then echo "OUT_DIR is required"; exit 1; fi
	@rm -rf generated-templates/$(OUT_DIR)/
	@mkdir -p generated-templates/$(OUT_DIR)
	helm template $(RELEASE) charts/$(CHART) --debug --namespace $(NAMESPACE) --output-dir generated-templates/$(OUT_DIR) $(ADDITIONAL_HELM_FLAGS)

helm-install-template:
	@if [ "$$(kubectl config current-context)" != "kind-$(CLUSTER_NAME)" ]; then echo "You must be connected to the kind cluster 'kind-$(CLUSTER_NAME)'"; exit 1; fi
	@if [ -z "$(RELEASE)" ]; then echo "RELEASE is required"; exit 1; fi
	@if [ -z "$(CHART)" ]; then echo "CHART is required"; exit 1; fi
	@if [ -z "$(NAMESPACE)" ]; then echo "NAMESPACE is required"; exit 1; fi
	@if [ "$(ONLY_TEMPLATES)" -eq "1" ]; then \
		echo "ONLY_TEMPLATES is set to '1'. Skipping installation"; \
		exit 0; \
	else \
		helm upgrade --install $(RELEASE) charts/$(CHART) --wait --debug --create-namespace --namespace $(NAMESPACE) $(ADDITIONAL_HELM_FLAGS); \
	fi
