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

ARG IMAGE_1=cgr.dev/chainguard/python:3.11-dev@sha256:c7267ad0f84dd8b44fcea8962a0a97f44e719b703cf57321bff1576269a8043b
ARG IMAGE_2=cgr.dev/chainguard/python:3.11@sha256:12c0aeacf184fc70e2719147885f46ced54d781ec3deeddaa80f7f9a42dc61ec

FROM ${IMAGE_1} as builder

WORKDIR /app

USER root
RUN apk add --no-cache --update-cache curl curl-dev libcurl-openssl4 openssl openssl-dev

USER nonroot
RUN pip install trafilatura[all]

FROM ${IMAGE_2}

LABEL org.opencontainers.image.title="trafilatura" \
      org.opencontainers.image.description="trafilatura" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/trafilatura" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/trafilatura" \
      org.opencontainers.image.license="MIT"

WORKDIR /app

ENV PATH=$PATH:/home/nonroot/.local/bin

# Make sure you update Python version in path
COPY --from=builder /home/nonroot/.local/lib/python3.11/site-packages /home/nonroot/.local/lib/python3.11/site-packages
COPY --from=builder /home/nonroot/.local/bin /home/nonroot/.local/bin

ENTRYPOINT [ "trafilatura" ]