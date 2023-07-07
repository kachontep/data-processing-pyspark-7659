#!/usr/bin/env bash

NOTEBOOK_DIR="${GITPOD_REPO_ROOT}/notebooks"

if [ ! -e "${NOTEBOOK_DIR}" ]; then
    mkdir -p $NOTEBOOK_DIR
fi 

# Disable token for accessing jupyter server
jupyter notebook --generate-config -y
sed -i "s/^# c.NotebookApp.token = .*/c.NotebookApp.token = ''/" $HOME/.jupyter/jupyter_notebook_config.py

jupyter notebook --no-browser --ip 0.0.0.0 --notebook-dir=${NOTEBOOK_DIR}