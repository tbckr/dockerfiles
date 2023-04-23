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

# this is kind of an expensive check, so let's not do this twice if we
# are running more than one validate bundlescript
VALIDATE_REPO='https://github.com/tbckr/dockerfiles.git'
VALIDATE_BRANCH='main'

VALIDATE_HEAD="$(git rev-parse --verify HEAD)"

git fetch -q "$VALIDATE_REPO" "refs/heads/$VALIDATE_BRANCH"
VALIDATE_UPSTREAM="$(git rev-parse --verify FETCH_HEAD)"

# FIX: The error message indicates that the script is trying to compare two unrelated branches, which means they do not share a common base commit. The git diff command cannot process such a comparison.
# VALIDATE_COMMIT_DIFF="$VALIDATE_UPSTREAM...$VALIDATE_HEAD"
VALIDATE_COMMIT_DIFF="$VALIDATE_UPSTREAM $VALIDATE_HEAD"

validate_diff() {
  if [ "$VALIDATE_UPSTREAM" != "$VALIDATE_HEAD" ]; then
    git diff "$VALIDATE_COMMIT_DIFF" "$@"
  else
    git diff HEAD~ "$@"
  fi
}

# get the dockerfiles changed
IFS=$'\n'
# shellcheck disable=SC2207
files=($(validate_diff --name-only -- '*Dockerfile'))
unset IFS

# build the changed dockerfiles
# shellcheck disable=SC2068
for f in ${files[@]}; do
  if ! [[ -e "$f" ]]; then
    continue
  fi

  build_dir=$(dirname "$f")
  base="${build_dir%%\/*}"
  suite="${build_dir##$base}"
  suite="${suite##\/}"

  if [[ -z "$suite" ]]; then
    suite=latest
  fi

  (
    set -x
    docker build -t "${base}:${suite}" "${build_dir}"
  )

  echo "                       ---                                   "
  echo "Successfully built ${base}:${suite} with context ${build_dir}"
  echo "                       ---                                   "
done
