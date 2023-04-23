FROM cgr.dev/chainguard/node:18.16

LABEL org.opencontainers.image.title="markdownlint" \
      org.opencontainers.image.description="markdownlint" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.license="MIT"

VOLUME /app
WORKDIR /app

USER root
RUN npm install -g markdownlint-cli

USER node
ENTRYPOINT ["markdownlint"]
CMD ["."]