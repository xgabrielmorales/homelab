#!/usr/bin/env bash

# Description:
#   Decrypts a sops-encrypted secrets file and exports its variables. Accepts
#   .env or .yml. Fails if the file does not exist.
#
# Usage:
#   use sops "secrets.yml"

use_sops() {
    local secrets_file
    secrets_file="$1"

    if [[ -f $secrets_file ]]; then
        eval "$(sops --decrypt "$secrets_file" | direnv dotenv bash /dev/stdin)"
        watch_file "$secrets_file"
    else
        log_status "Error: Secrets file '$secrets_file' not found." >&2
        return 1
    fi
}
