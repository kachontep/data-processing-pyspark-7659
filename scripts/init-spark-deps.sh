#!/usr/bin/env bash

SPARK_DEPS_DIR="./spark-deps"

mkdir -p $SPARK_DEPS_DIR

# Dependencies for S3A protocol accessing (used with MinIO server)
mvn dependency:copy -Dartifact=org.apache.hadoop:hadoop-aws:3.3.1:jar -DoutputDirectory=$SPARK_DEPS_DIR
mvn dependency:copy -Dartifact=com.amazonaws:aws-java-sdk-bundle:1.11.901:jar -DoutputDirectory=$SPARK_DEPS_DIR

sudo cp $SPARK_DEPS_DIR/*.jar $SPARK_HOME/jars