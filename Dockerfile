FROM alpine

LABEL maintainer "Knut Ahlers <knut@luzifer.io>"

ENV VAULT_VERSION 0.9.4
ENV VAULT_HASH b312dfe783f69f5284d350714468f005dbb023f26ac9525d267550fb3dd2eea5

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
