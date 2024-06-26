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

ARG IMAGE_1=cgr.dev/chainguard/wolfi-base:latest@sha256:c9339087a6de501ba6989756aeb1e1c89af82ac0e53c8b1ccd1feb44ec2246d9
ARG IMAGE_2=cgr.dev/chainguard/static:latest@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

FROM ${IMAGE_1} as builder

ENV TARGETOS=linux
ENV TARGETARCH=amd64

# renovate: datasource=github-releases depName=terraform-linters/tflint
ENV TFLINT_VERSION=v0.51.1
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-aws
ENV AWS_VERSION=v0.32.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-azurerm
ENV AZURERM_VERSION=v0.26.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-google
ENV GOOGLE_VERSION=v0.29.0

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