#!/usr/bin/env bash
#

dir="$(dirname ${BASH_SOURCE[0]})"
dyno="${DYNO%.*}"
ctypes="${LEMMA_DYNO_TYPE:-web}"
types=$(echo $ctypes | tr "," "\n")

for dtype in $types ; do
  if [[ "$dyno" == "$dtype" ]] ; then
    start_lemmad=true
  fi
done

if [[ -n "$start_lemmad" ]] ; then
  chmod +x $dir/lemmad
  { while :; do $dir/lemmad ; done ; } &
fi
