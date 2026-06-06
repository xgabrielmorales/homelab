#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="./volume-backups"
IMAGE="alpine"

usage() {
  cat >&2 <<EOF
Usage: ${0##*/} <command> [options]

Commands:
  backup              Archive all Docker volumes to a timestamped directory.
  restore <dir>       Recreate and populate volumes from a backup directory.

Options:
  -h, --help          Show this help.
EOF
  exit "${1:-0}"
}

backup() {
  local dir
  dir="$ROOT_DIR/$(date +%Y-%m-%d_%H-%M-%S)"

  mkdir -p "$dir"

  for volume in $(docker volume ls --quiet); do
    docker run --rm \
      --volume="$volume":/data \
      --volume="$dir":/backup \
      "$IMAGE" \
      tar czf "/backup/${volume}.tar.gz" -C /data .
  done

  printf '%s\n' "$dir"
}

restore() {
  local dir="$1"

  if [ ! -d "$dir" ]; then
    printf 'No such backup directory: %s\n' "$dir" >&2
    exit 1
  fi

  for archive in "$dir"/*.tar.gz; do
    if [ ! -e "$archive" ]; then
      printf 'No archives found in: %s\n' "$dir" >&2
      exit 1
    fi

    local volume
    volume=$(basename "$archive" .tar.gz)

    docker volume create "$volume" >/dev/null
    docker run --rm \
      --volume="$volume":/data \
      --volume="$dir":/backup \
      "$IMAGE" \
      tar xzf "/backup/${volume}.tar.gz" -C /data
  done
}

main() {
  case "${1:-}" in
    backup)
      shift
      backup "$@"
      ;;
    restore)
      shift
      if [ $# -lt 1 ]; then
        usage 1
      fi
      restore "$1"
      ;;
    -h|--help)
      usage 0
      ;;
    *)
      usage 1
      ;;
  esac
}

main "$@"
