FROM alpine:3.22@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

ARG VAULT_VERSION=1.21.0 # renovate: packageName=hashicorp/vault datasource=github-releases

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
