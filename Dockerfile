FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

ARG VAULT_VERSION=2.0.0 # renovate: packageName=hashicorp/vault datasource=github-releases

LABEL maintainer="Knut Ahlers <knut@luzifer.io>"

ENV HOME=/home/vault

RUN set -xe \
 && apk --no-cache add \
      ca-certificates \
      curl \
 && curl -sSLfo /tmp/vault.zip "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" \
 && mkdir -p /opt/vault \
 && unzip /tmp/vault.zip -d /opt/vault \
 && rm /tmp/vault.zip \
 && ln -sf /opt/vault/vault /usr/local/bin/vault \
 && apk --no-cache del \
      curl \
 && adduser -D -u 1000 vault

USER vault

VOLUME ["/home/vault/config"]
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["server", "-config=/home/vault/config"]
