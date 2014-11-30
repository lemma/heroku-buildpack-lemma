#!/usr/bin/env bash
#

dir="$(dirname ${BASH_SOURCE[0]})"
dyno="${DYNO%.*}"
ctypes="${LEMMA_DYNO_TYPE:-web}"
types=$(echo $ctypes | tr "," "\n")

for dtype in $types ; do
  if [[ "$dyno" == "$dtype" ]] ; then
    chmod +x $dir/lemmad
    $dir/lemmad &

    exit 0
  fi
done
