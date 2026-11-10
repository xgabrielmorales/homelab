#!/usr/bin/env bash

# Description:
#   Decrypts the `kubeconfig` key of a sops (age) file into $XDG_RUNTIME_DIR
#   (tmpfs, 0700, cleared at logout) and points KUBECONFIG at it. Never written
#   to the repo or to the direnv cache on disk.
#
# Usage:
#   use kubeconfig "secrets.enc.yml"

use_kubeconfig() {
    local encrypted_file runtime_dir kubeconfig
    encrypted_file="$1"
    runtime_dir="${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR is not set, cannot store the kubeconfig}"
    kubeconfig="$runtime_dir/homelab-kubeconfig"

    watch_file "$encrypted_file"

    if (umask 077 && sops --decrypt --extract '["KUBECONFIG"]' "$encrypted_file" >"$kubeconfig" 2>/dev/null); then
        export KUBECONFIG="$kubeconfig"
    else
        rm -f "$kubeconfig"
        log_status "kubeconfig: could not decrypt key 'kubeconfig' from '$encrypted_file' (age key in SOPS_AGE_KEY_FILE), skipping."
    fi
}
