#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

source $BASEDIR/spark-cluster-env.sh

# Stop workers
for i in $(seq 0 $(($WORKER_NUM - 1))) ; do
    export SPARK_WORKER_DIR="$GITPOD_REPO_ROOT/spark_runs/works/worker${i}"
    export SPARK_LOG_DIR="$GITPOD_REPO_ROOT/spark_runs/logs/worker${i}"
    export SPARK_PID_DIR="$GITPOD_REPO_ROOT/spark_runs/pids/worker${i}"

    $SPARK_HOME/sbin/stop-worker.sh
done

# Stop master
export SPARK_LOG_DIR="$GITPOD_REPO_ROOT/spark_runs/logs/master"
$SPARK_HOME/sbin/stop-master.sh