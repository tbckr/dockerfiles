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

ARG IMAGE=node:18-alpine@sha256:054a4be31e7dd879d7b238c68ad9c23b7969686a725305b4edb7c80656c00194
FROM ${IMAGE}

# renovate: datasource=npm depName=markdownlint-cli
ENV MARKDOWNLINT_VERSION=0.43.0

LABEL org.opencontainers.image.title="markdownlint" \
      org.opencontainers.image.description="markdownlint" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/markdownlint" \
      org.opencontainers.image.license="MIT"

VOLUME /app
WORKDIR /app

RUN npm install -g markdownlint-cli@${MARKDOWNLINT_VERSION}

ENTRYPOINT ["markdownlint"]
CMD ["."]