#!/usr/bin/env bash

set -eo pipefail
shopt -s nullglob

BASE=$(dirname "${0}")

source "${BASE}/common.sh"

get_kind

"${KIND_BIN}" create cluster --name "${CLUSTER_NAME}" ${CONFIG_OPT} --wait 60s --image "kindest/node:${CLUSTER_VERSION}"
