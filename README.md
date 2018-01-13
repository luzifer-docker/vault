# luzifer-docker / vault

This container contains the Hashicorp Vault binary in an Alpine Linux container and by default starts a Vault server.

## Usage

```bash
## Build container (optional)
$ docker build -t luzifer/vault .

## Create config
$ tree
.
└── config.hcl

0 directories, 1 files

## Execute vault
$ docker run --rm -ti -v $(pwd):/home/vault/config luzifer/curator
```
