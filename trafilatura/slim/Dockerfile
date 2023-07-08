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

ARG IMAGE_1=cgr.dev/chainguard/python:3.11-dev@sha256:6fdab47ffc1a86e1e2325eb5d2552c0f2cf8396305d8379a6ce55294d0bd6807
ARG IMAGE_2=cgr.dev/chainguard/python:3.11@sha256:425c33f329c94645754dd78632a30090cb30c48c3f639f4a69f872ac0352b33a

FROM ${IMAGE_1} as builder

WORKDIR /app

USER nonroot
RUN pip install trafilatura

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