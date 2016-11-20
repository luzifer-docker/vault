FROM alpine

MAINTAINER Knut Ahlers <knut@luzifer.io>

ENV VAULT_VERSION 0.6.2
ENV VAULT_HASH 91432c812b1264306f8d1ecf7dd237c3d7a8b2b6aebf4f887e487c4e7f69338c

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
