FROM alpine

LABEL maintainer "Knut Ahlers <knut@luzifer.io>"

ENV VAULT_VERSION 0.9.1
ENV VAULT_HASH 6308013ee0d6278e98cdfe8d6de0162102a8d25f3bcd1e3737bf7b022a9f6702

ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.zip

RUN set -xe \
 && apk add --update ca-certificates \
 && echo "${VAULT_HASH}  /tmp/vault.zip" | sha256sum -c \
 && mkdir -p /opt/vault \
 && unzip /tmp/vault.zip -d /opt/vault \
 && ln -sf /opt/vault/vault /usr/local/bin/vault \
 && adduser -D -u 1000 vault

USER vault

VOLUME ["/home/vault/config"]
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["server", "-config=/home/vault/config"]
