FROM bitnami/cosign:latest
USER root
RUN apt-get update
RUN apt-get install -y curl vim
USER 1001
