#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
## Author: Jeff Malone, 05 May 2019
##

set -euo pipefail

HOOKNAME="$(basename $0)"
if [[ $HOOKNAME = "hooks.sh" ]]; then
    echo "FATAL: this script is not meant to be called, unless being symlinked as a git hook"
    exit 1
fi
HOOKDIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )/$HOOKNAME"

#echo "$(date) $PWD $0 $HOOKDIR $@" | tee -a /tmp/hooks.log
#ls -la $HOOKDIR | tee -a /tmp/hooks.log
ARRAY=() # creates an empty array
for var in "$@"; do
    ARRAY+=("--arg=$var") # append to an array
done

run-parts --exit-on-error --regex ".*(py|sh|pl)" "${ARRAY[@]}" -- $HOOKDIR
exit 0

