#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

source $BASEDIR/spark-cluster-env.sh

# Start master
export SPARK_PID_DIR="$GITPOD_REPO_ROOT/spark_runs/pids/master"
export SPARK_LOG_DIR="$GITPOD_REPO_ROOT/spark_runs/logs/master"

$SPARK_HOME/sbin/start-master.sh

# Wait for master to open service port 7077 and 8080
gp ports await 7077
gp ports await 8080

echo "All Spark master ports ready!"

# Start workers
for i in $(seq 0 $((WORKER_NUM - 1))) ; do
    export SPARK_LOG_DIR="$GITPOD_REPO_ROOT/spark_runs/logs/worker${i}"
    export SPARK_WORKER_DIR="$GITPOD_REPO_ROOT/spark_runs/works/worker${i}"
    export SPARK_PID_DIR="$GITPOD_REPO_ROOT/spark_runs/pids/worker${i}"
    export SPARK_WORKER_UI_PORT="$((8081 + $i))"
    export SPARK_WORKER_OPTS="-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.interval=300 -Dspark.worker.cleanup.appDataTtl=900"

    $SPARK_HOME/sbin/start-worker.sh -c $WORKER_CORES -m $WORKER_MEM spark://localhost:7077
done