#!/bin/sh
set -oe errexit

CLUSTER_NAME="blackfire-chart"
CLUSTER_VERSION="v1.21.12"

if [[ $(./bin/kind get clusters | grep ${CLUSTER_NAME}) ]]; then
    echo "Cluster ${CLUSTER_NAME} already exists, doing nothing.";
    kubectl cluster-info --context kind-${CLUSTER_NAME}
    exit 0
fi

./bin/kind create cluster --config ./scripts/cluster.yaml --name ${CLUSTER_NAME} --wait 30s --image kindest/node:${CLUSTER_VERSION}
