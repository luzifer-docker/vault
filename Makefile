VERSION=$(shell grep 'ENV VAULT_VERSION' Dockerfile | cut -d ' ' -f 3)

default: check tag

build:
		docker build -t local/vault-testing .

check: build
		docker run --rm local/vault-testing --version | grep -q "Vault v${VERSION}"

tag:
	git tag | grep -q "${VERSION}" && git tag -d "${VERSION}" || true
	git tag "${VERSION}"
