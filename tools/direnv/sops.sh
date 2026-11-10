#!/usr/bin/env bash

# Description:
#   Decrypts a sops-encrypted secrets file and exports its variables. Accepts
#   .env or .yml. Fails if the file does not exist.
#
# Usage:
#   use sops "environment/dev/secrets.yml"

use_sops() {
    local secrets_file
    secrets_file="$1"

    if [[ -f $secrets_file ]]; then
        # Only single-line string values become env vars; multiline ones (e.g. kubeconfig) are read by their own helper.
        local exports
        exports="$(sops --decrypt --output-type json "$secrets_file" | jq -r '
            to_entries[] | select(.value | type == "string" and (contains("\n") | not))
            | "export \(.key)=\(.value | @sh)"')" || return 1
        eval "$exports"
        watch_file "$secrets_file"
    else
        log_status "Error: Secrets file '$secrets_file' not found." >&2
        return 1
    fi
}
