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

ARG IMAGE_1=cgr.dev/chainguard/python:3.11-dev@sha256:d7e843a54d480a6941c2d560c7408f93fb726ffdfdf7454d43b8907a35df292f
ARG IMAGE_2=cgr.dev/chainguard/python:3.11@sha256:6e512c60467cb53572112d8b5f1200d93cc7f883db01e57836fd93754f6bb4e8

FROM ${IMAGE_1} as builder

WORKDIR /app
COPY remote-src/requirements.txt .

# TODO: kerberos is not installed in the builder image
# fix: comment gssapi[kerberos] in requirements.txt to avoid build error
USER root
RUN sed -i 's/^gssapi\[kerberos\]/#&/' requirements.txt

USER nonroot
RUN pip install -r requirements.txt --user

FROM ${IMAGE_2}

LABEL org.opencontainers.image.title="offlineimap3" \
      org.opencontainers.image.description="offlineimap3" \
      org.opencontainers.image.url="https://github.com/tbckr/dockerfiles/tree/main/offlineimap3" \
      org.opencontainers.image.src="https://github.com/tbckr/dockerfiles/tree/main/offlineimap3" \
      org.opencontainers.image.license="MIT"

WORKDIR /app

VOLUME /home/nonroot/.offlineimaprc
VOLUME /home/nonroot/mail

# Make sure you update Python version in path
COPY --from=builder /home/nonroot/.local/lib/python3.11/site-packages /home/nonroot/.local/lib/python3.11/site-packages
COPY remote-src/. .

ENTRYPOINT [ "python", "/app/offlineimap.py" ]