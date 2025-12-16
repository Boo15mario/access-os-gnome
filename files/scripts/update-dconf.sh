#!/usr/bin/env bash
set -oue pipefail

# Rebuild the system dconf database to pick up defaults under /etc/dconf/db/local.d/
dconf update
