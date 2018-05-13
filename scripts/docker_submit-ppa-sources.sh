#!/bin/bash

set -euo pipefail

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/env.sh"

declare -i processes_default=2
declare -i processes=${1:-"$processes_default"}
declare -i build=${2:-${version_build}}
declare -a args=()

declare distro='ubuntu'
for release in "${releases_ubuntu[@]}"; do
    echo "[INFO ] Uploading sources for $distro/$release"
    docker run \
    --rm \
    -v $dir_base:/liquorix-package \
    -t "liquorix_$source_arch/$source_distro/$source_release" \
    /liquorix-package/scripts/container_dput-to-ppa.sh \
        "$distro" \
        "$release" \
        "$build"
done
