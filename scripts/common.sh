#!/usr/bin/env bash

CLUSTER_NAME=${CLUSTER_NAME:-"test-charts"}
export CLUSTER_NAME
CLUSTER_VERSION=${CLUSTER_VERSION:-"v1.31.9"}
export CLUSTER_VERSION

KIND_VERSION="${KIND_VERSION:-0.29.0}"
export KIND_VERSION
KIND_BIN="$(command -v kind || true)"
export KIND_BIN

OS=$(uname | awk '{ print tolower($0) }')
echo "Detected OS: ${OS}"

ARCH="amd64"
if [ "$(uname -m)" = "arm64" ]; then
  ARCH="arm64"
fi
echo "Detected ARCH: ${ARCH}"

get_kind() {
  # shellcheck disable=SC2143
  if [ ! "${KIND_BIN}" ] || [ ! "$(${KIND_BIN} version | grep "${KIND_VERSION}")" ]; then
    [ "${CI}" = "true" ] && KIND_PATH="/usr/local/bin" || KIND_PATH="./bin"
    mkdir -p "${KIND_PATH}"
    curl -Lo "${KIND_PATH}/kind" "https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-${OS}-${ARCH}"
    chmod +x "${KIND_PATH}/kind"
    export KIND_BIN="${KIND_PATH}/kind"
  fi
  echo -e "\nINFO: Using kind from \"${KIND_BIN}\" version \"$(${KIND_BIN} version)\"\n"
}
