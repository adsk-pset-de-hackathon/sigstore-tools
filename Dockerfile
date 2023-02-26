FROM bitnami/cosign:latest
USER root
RUN apt-get update
RUN apt-get install -y curl vim dnsutils jq git telnet mariadb-client python3-minimal python3-pip
RUN python3 -m pip install --upgrade pip && pip install awscli
COPY ./custom-sigstore-public-keys /custom-sigstore-public-keys
RUN chmod -R 644 /custom-sigstore-public-keys && chmod 755 /custom-sigstore-public-keys
COPY ./bin /usr/local/bin
RUN mkdir -p /tmp/spire && cd /tmp/spire && curl -L https://github.com/spiffe/spire/releases/download/v1.5.5/spire-1.5.5-linux-x86_64-glibc.tar.gz -o spire.tar.gz && tar -xzf spire.tar.gz --strip-components=1 && chmod 755 ./bin/spire-agent && mv ./bin/spire-agent /usr/local/bin/ && rm -rf /tmp/spire 
# NOTE we are using a custom build of witness to allow for spire OIDC keyless ambient tokens: https://github.com/testifysec/witness/tree/fulcio-ambient-tokens
#RUN cd /tmp && curl -L https://github.com/testifysec/witness/releases/download/v0.1.12/witness_0.1.12_linux_amd64.tar.gz -o witness.tar.gz && tar -xzf witness.tar.gz && chmod 755 witness && mv witness /usr/local/bin && rm witness.tar.gz
COPY ./scripts /scripts
RUN chmod -R 755 /scripts
#RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc --create-dirs -o /usr/local/bin/mc && chmod +x /usr/local/bin/mc
USER 1000
LABEL org.opencontainers.image.source=https://github.com/adsk-pset-de-hackathon/sigstore-tools
LABEL org.opencontainers.image.description="Sigstore tools container image"
LABEL org.opencontainers.image.licenses=MIT
