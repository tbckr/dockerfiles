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

ARG IMAGE_1=cgr.dev/chainguard/wolfi-base:latest@sha256:d653e81239ff979cf810ca6f706d1bcf56d6994da75f37b4702327a3c2696900
ARG IMAGE_2=cgr.dev/chainguard/static:latest@sha256:f5fe67ab41c65f55766d824a2d857a7f56c9058b8e077c43d4d809c467f28df8

FROM ${IMAGE_1} as builder

ENV TARGETOS=linux
ENV TARGETARCH=amd64

# renovate: datasource=github-releases depName=terraform-linters/tflint
ENV TFLINT_VERSION=v0.54.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-aws
ENV AWS_VERSION=v0.36.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-azurerm
ENV AZURERM_VERSION=v0.27.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-google
ENV GOOGLE_VERSION=v0.30.0

USER root
RUN apk add --no-cache wget unzip && \
    rm -rf /var/cache/apk/*

USER nonroot
RUN mkdir -p ~/bin && \
    mkdir -p ~/.tflint.d/plugins

RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION#v}"/tflint_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint.zip -d /home/nonroot/bin \
  && rm /tmp/tflint.zip

RUN wget -O /tmp/tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${AWS_VERSION#v}"/tflint-ruleset-aws_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-aws.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-aws.zip

RUN wget -O /tmp/tflint-ruleset-azurerm.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v"${AZURERM_VERSION#v}"/tflint-ruleset-azurerm_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-azurerm.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-azurerm.zip

RUN wget -O /tmp/tflint-ruleset-google.zip https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v"${GOOGLE_VERSION#v}"/tflint-ruleset-google_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-google.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-google.zip


FROM ${IMAGE_2}

LABEL org.opencontainers.image.title="tflint" \
      org.opencontainers.image.description="tflint" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/tflint" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/tflint" \
      org.opencontainers.image.license="MIT"

COPY --from=builder /home/nonroot/bin/tflint /tflint
COPY --from=builder /home/nonroot/.tflint.d /home/nonroot/.tflint.d

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/tflint"]
CMD ["--help"]