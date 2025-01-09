# Copyright (c) 2024 Tim <tbckr>
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

FROM golang:1.23.4-alpine@sha256:04ec5618ca64098b8325e064aa1de2d3efbbd022a3ac5554d49d5ece99d41ad5 AS builder
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest && \
    xcaddy build \
        --with github.com/tailscale/caddy-tailscale

FROM caddy:2-alpine@sha256:11d5f24d2eda731dfe6c70a9c9d127477e9d2c087f20aa889f6f55b1bc5ca612
COPY --from=builder /go/caddy /usr/bin/caddy