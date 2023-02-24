FROM bitnami/cosign:latest
USER root
RUN apt-get update
RUN apt-get install -y curl vim
COPY ./custom-sigstore-public-keys /custom-sigstore-public-keys
RUN chmod 755 /custom-sigstore-public-keys

LABEL org.opencontainers.image.source=https://github.com/adsk-pset-de-hackathon/sigstore-tools
LABEL org.opencontainers.image.description="Sigstore tools container image"
LABEL org.opencontainers.image.licenses=MIT
