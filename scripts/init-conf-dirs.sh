#!/usr/bin/env bash

# Set livy configuration directory
gp env LIVY_CONF_DIR="${GITPOD_REPO_ROOT}/conf_dirs/livy"

# Set spark configuration directory
gp env SPARK_CONF_DIR="${GITPOD_REPO_ROOT}/conf_dirs/spark"

# Synchronize with other tasks
gp sync-done init-conf-dirs