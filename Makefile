KIND_VERSION=v0.14.0
UNAME_S := $(shell uname -s | tr A-Z a-z)

all: test

install-kind:
	@echo "Installing kind ${KIND_VERSION} to ./bin/kind"
	@mkdir -p bin
	@curl -s -Lo ./bin/kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-$(UNAME_S)-amd64
	@chmod +x ./bin/kind
	@echo "...done!"

create-kind-cluster: install-kind
	./scripts/create-kind.sh

test:
	helm install blackfire-test . --wait --debug --namespace default --set blackfire.server_id=$(BLACKFIRE_SERVER_ID) --set blackfire.server_token=$(BLACKFIRE_SERVER_TOKEN)