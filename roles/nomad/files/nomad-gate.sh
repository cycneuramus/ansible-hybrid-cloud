#!/bin/bash

set -euo pipefail

log="$HOME/log/$(basename "$0" .sh).log"
nomad_addr=http://127.0.0.1:4646

mkdir -p "$(dirname "$log")"
: > "$log"
exec &> >(tee -a "$log")

log() { printf '[nomad-gate] %s\n' "$*"; }

exec 9> /tmp/nomad-gate.lock
flock -n 9 || {
	log "another instance is running"
	exit 0
}

until curl -sf "$nomad_addr/v1/status/leader" | grep -q :; do
	log "waiting for Nomad leader…"
	sleep 5
done

nmgr down services -d || {
	log "nmgr down services failed"
	exit 1
}
nmgr down infra -d || {
	log "nmgr down infra failed"
	exit 1
}

deadline=$((SECONDS + 120))
until mountpoint -q /mnt/nas; do
	if ((SECONDS >= deadline)); then
		log "error: timeout waiting for NAS mount"
		exit 1
	fi
	sleep 5
done

nmgr up infra

deadline=$((SECONDS + 180))
until mountpoint -q /mnt/jfs; do
	if ((SECONDS >= deadline)); then
		log "error: timeout waiting for JuiceFS mount"
		exit 1
	fi
	sleep 5
done

nmgr up services -d || {
	log "nmgr up services failed"
	exit 1
}

log "done"
