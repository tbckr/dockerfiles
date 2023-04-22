#!/bin/bash
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

set -e
set -o pipefail

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="${REPO_URL:-ghcr.io/tbckr}"
JOBS=${JOBS:-2}

ERRORS="$(pwd)/errors"

build_and_push() {
  base=$1
  suite=$2
  build_dir=$3

  echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
  docker build --rm --force-rm -t "${REPO_URL}/${base}:${suite}" "${build_dir}" || return 1

  # on successful build, push the image
  echo "                       ---                                   "
  echo "Successfully built ${base}:${suite} with context ${build_dir}"
  echo "                       ---                                   "

  # try push a few times because notary server sometimes returns 401 for
  # absolutely no reason
  n=0
  until [ $n -ge 5 ]; do
    docker push --disable-content-trust=false "${REPO_URL}/${base}:${suite}" && break
    echo "Try #$n failed... sleeping for 15 seconds"
    n=$((n + 1))
    sleep 15
  done

  # also push the tag latest for "stable" (chrome), "tools" (wireguard) or "3.5" tags for zookeeper
  if [[ "$suite" == "stable" ]] || [[ "$suite" == "3.6" ]] || [[ "$suite" == "tools" ]]; then
    docker tag "${REPO_URL}/${base}:${suite}" "${REPO_URL}/${base}:latest"
    docker push --disable-content-trust=false "${REPO_URL}/${base}:latest"
  fi
}

dofile() {
  f=$1
  image=${f%Dockerfile}
  base=${image%%\/*}
  build_dir=$(dirname "$f")
  suite=${build_dir##*\/}

  if [[ -z "$suite" ]] || [[ "$suite" == "$base" ]]; then
    suite=latest
  fi

  {
    $SCRIPT build_and_push "${base}" "${suite}" "${build_dir}"
  } || {
    # add to errors
    echo "${base}:${suite}" >>"$ERRORS"
  }
  echo
  echo
}

main() {
  # get the dockerfiles
  IFS=$'\n'
  mapfile -t files < <(find -L . -iname '*Dockerfile' | sed 's|./||' | sort)
  unset IFS

  # build all dockerfiles
  echo "Running in parallel with ${JOBS} jobs."
  parallel --tag --verbose --ungroup -j"${JOBS}" "$SCRIPT" dofile "{1}" ::: "${files[@]}"

  if [[ ! -f "$ERRORS" ]]; then
    echo "No errors, hooray!"
  else
    echo "[ERROR] Some images did not build correctly, see below." >&2
    echo "These images failed: $(cat "$ERRORS")" >&2
    exit 1
  fi
}

run() {
  args=$*
  f=$1

  if [[ "$f" == "" ]]; then
    main "$args"
  else
    $args
  fi
}

run "$@"
