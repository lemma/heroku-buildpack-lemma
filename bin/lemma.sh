#!/usr/bin/env bash -e
#

dir="$(dirname ${BASH_SOURCE[0]})"

chmod +x $dir/lemmad
$dir/lemmad &
