#!/usr/bin/env bash

set -eo pipefail
shopt -s nullglob

BASE=$(dirname "${0}")

source "${BASE}/common.sh"

get_kind

# shellcheck disable=SC2143
if [ "$(${KIND_BIN} get clusters | grep "${CLUSTER_NAME}")" ]; then
  echo "Cluster \"${CLUSTER_NAME}\" found, deleting it...."
  "${KIND_BIN}" delete cluster --name "${CLUSTER_NAME}"
fi
