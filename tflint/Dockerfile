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

ARG MULTISTAGE_IMAGE_1=cgr.dev/chainguard/curl:8.0
FROM ${MULTISTAGE_IMAGE_1} as builder

ENV TARGETOS=linux
ENV TARGETARCH=amd64

# renovate: datasource=github-releases depName=terraform-linters/tflint
ENV TFLINT_VERSION=0.46.1
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-aws
ENV AWS_VERSION=0.23.0
# renovate: datasource=github-releases depName=terraform-linters/tflint-ruleset-azurerm
ENV AZURERM_VERSION=0.23.0
# renovate: datasource=github-releases depName=com/terraform-linters/tflint-ruleset-google
ENV GOOGLE_VERSION=0.23.1

RUN curl -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint.zip -d /usr/local/bin \
  && rm /tmp/tflint.zip

RUN mkdir -p ~/.tflint.d/plugins

RUN curl -O /tmp/tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${AWS_VERSION}"/tflint-ruleset-aws_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-aws.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-aws.zip

RUN curl -O /tmp/tflint-ruleset-azurerm.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v"${AZURERM_VERSION}"/tflint-ruleset-azurerm_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-azurerm.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-azurerm.zip

RUN curl -O /tmp/tflint-ruleset-google.zip https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v"${GOOGLE_VERSION}"/tflint-ruleset-google_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-google.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-google.zip


ARG MULTISTAGE_IMAGE_2=cgr.dev/chainguard/static:latest@sha256:3ee375b4539717ebcdb96ffc9d94ebb15bc5d950b9d714bd0545997b5aec1c19
FROM ${MULTISTAGE_IMAGE_2}

LABEL maintainer=terraform-linters

RUN apk add --no-cache ca-certificates

COPY --from=builder /usr/local/bin/tflint /usr/local/bin
COPY --from=builder /root/.tflint.d /root/.tflint.d

ENTRYPOINT ["tflint"]
WORKDIR /data