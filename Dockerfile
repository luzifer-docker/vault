FROM alpine

MAINTAINER Knut Ahlers <knut@luzifer.io>

ENV VAULT_VERSION 0.6.2
ENV VAULT_HASH f62340a33d8f4e6d71c2bd748ba279d88b5c63ab33a73a36dca402ecbf084f2f

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
