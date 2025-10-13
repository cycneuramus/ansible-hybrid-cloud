#!/bin/sh

case "$3" in
	MASTER) systemctl start valkey.service ;;
	BACKUP | FAULT) systemctl stop valkey.service ;;
esac
