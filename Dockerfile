FROM alpine

MAINTAINER Knut Ahlers <knut@luzifer.io>

ENV VAULT_VERSION 0.6.1
ENV VAULT_HASH 4f248214e4e71da68a166de60cc0c1485b194f4a2197da641187b745c8d5b8be

ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.zip

RUN set -xe \
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
