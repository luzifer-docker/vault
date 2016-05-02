FROM alpine

MAINTAINER Knut Ahlers <knut@luzifer.io>

ENV VAULT_VERSION 0.5.2
ENV VAULT_HASH 7517b21d2c709e661914fbae1f6bf3622d9347b0fe9fc3334d78a01d1e1b4ec2

ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.zip

RUN set -xe \
 && echo "${VAULT_HASH}  /tmp/vault.zip" | sha256sum -c \
 && mkdir -p /opt/vault \
 && unzip /tmp/vault.zip -d /opt/vault \
 && ln -sf /opt/vault/vault /usr/local/bin/vault \
 && adduser -D -u 1000 vault

USER vault

VOLUME ["/home/vault/config"]

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["-config=/home/vault/config"]
