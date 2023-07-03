#!/usr/bin/env bash

export MINIO_OPTS="$MINIO_OPTS --address :9000 --console-address :9090"
export MINIO_ROOT_USER="${MINIO_ROOT_USER:-admin}"
export MINIO_ROOT_PASSWORD="${MINIO_ROOT_PASSWORD:-adminadmin}"
export MINIO_VOLUMES="/workspace/minio/data"

if [ ! -e "${MINIO_VOLUMES}" ]; then
    mkdir -p ${MINIO_VOLUMES}
fi

minio server $MINIO_OPTS $MINIO_VOLUMES