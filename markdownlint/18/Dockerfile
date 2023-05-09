# Copyright (c) 2023 Tim <tbckr>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# SPDX-License-Identifier: MIT

ARG IMAGE=cgr.dev/chainguard/node:18.16@sha256:45720c0cb6b276a2885af4d97312aa6e74ad21a8a1caf9d1c1bb2f01dfc0a6f5
FROM ${IMAGE}

# renovate: datasource=npm depName=markdownlint-cli
ENV MARKDOWNLINT_VERSION=0.34.0

LABEL org.opencontainers.image.title="markdownlint" \
      org.opencontainers.image.description="markdownlint" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.license="MIT"

VOLUME /app
WORKDIR /app

USER root
RUN npm install -g markdownlint-cli@${MARKDOWNLINT_VERSION}

USER node
ENTRYPOINT ["markdownlint"]
CMD ["."]