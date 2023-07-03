#!/usr/bin/env bash

NOTEBOOK_DIR="${GITPOD_REPO_ROOT}/notebooks"

if [ ! -e "${NOTEBOOK_DIR}" ]; then
    mkdir -p $NOTEBOOK_DIR
fi 

jupyter notebook --no-browser --ip 0.0.0.0 --notebook-dir=${NOTEBOOK_DIR}