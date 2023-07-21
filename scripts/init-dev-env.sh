#!/usr/bin/env bash

#
# Spark
#

# Copy spark additional dependencies to $SPARK_HOME/jars
SPARK_DEPS_DIR="./spark-deps"

mkdir -p $SPARK_DEPS_DIR

# Dependencies for S3A protocol accessing (used with MinIO server)
mvn dependency:copy -Dartifact=org.apache.hadoop:hadoop-aws:3.3.1:jar -DoutputDirectory=$SPARK_DEPS_DIR
mvn dependency:copy -Dartifact=com.amazonaws:aws-java-sdk-bundle:1.11.901:jar -DoutputDirectory=$SPARK_DEPS_DIR

# Dependencies for MySQL connector
mvn dependency:copy -Dartifact=com.mysql:mysql-connector-j:8.0.33:jar -DoutputDirectory=$SPARK_DEPS_DIR

# Dependencies for Iceberg
mvn dependency:copy -Dartifact=org.apache.iceberg:iceberg-spark-runtime-3.2_2.12:1.3.0:jar -DoutputDirectory=$SPARK_DEPS_DIR
mvn dependency:copy -Dartifact=software.amazon.awssdk:bundle:2.18.41:jar -DoutputDirectory=$SPARK_DEPS_DIR
mvn dependency:copy -Dartifact=software.amazon.awssdk:url-connection-client:2.18.41:jar -DoutputDirectory=$SPARK_DEPS_DIR
mvn dependency:copy -Dartifact=software.amazon.awssdk:utils:2.18.41:jar -DoutputDirectory=$SPARK_DEPS_DIR

sudo cp $SPARK_DEPS_DIR/*.jar $SPARK_HOME/jars

#
# MinIO

# Create minio alias if non-existent
mc alias set minio http://localhost:9000 admin adminadmin