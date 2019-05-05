#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

f=manifest.json
_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
jq ".version = $(date +'%s')" $f > $_tempfile
mv -f $_tempfile $f
git add $f
