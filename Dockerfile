FROM alpine

LABEL maintainer "Knut Ahlers <knut@luzifer.io>"

ENV VAULT_VERSION 0.9.6
ENV VAULT_HASH 3f1f346ff7aaf367fed6a3e83e5a07fdc032f22860585e36c3674f9ead08dbaf

RUN set -xe \
 && apk --no-cache add curl ca-certificates \
 && curl -sSLfo /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
 && echo "${VAULT_HASH}  /tmp/vault.zip" | sha256sum -c \
 && mkdir -p /opt/vault \
 && unzip /tmp/vault.zip -d /opt/vault && rm /tmp/vault.zip \
 && ln -sf /opt/vault/vault /usr/local/bin/vault \
 && apk --no-cache del curl \
 && adduser -D -u 1000 vault

USER vault

VOLUME ["/home/vault/config"]
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["server", "-config=/home/vault/config"]
