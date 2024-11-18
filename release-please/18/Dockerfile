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

ARG IMAGE=node:18-alpine@sha256:7e43a2d633d91e8655a6c0f45d2ed987aa4930f0792f6d9dd3bffc7496e44882
FROM ${IMAGE}

# renovate: datasource=npm depName=release-please
ENV RELEASE_PLEASE_VERSION=16.14.3

LABEL org.opencontainers.image.title="release-please" \
      org.opencontainers.image.description="release-please" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/release-please" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/release-please" \
      org.opencontainers.image.license="MIT"

VOLUME /app
WORKDIR /app

RUN npm install -g release-please@${RELEASE_PLEASE_VERSION}

ENTRYPOINT ["release-please"]