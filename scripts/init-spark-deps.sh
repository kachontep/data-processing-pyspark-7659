#!/usr/bin/env bash

mkdir ./spark-jars

# Dependencies for S3A protocol accessing (used with MinIO server)
mvn dependency:copy -Dartifact=org.apache.hadoop:hadoop-aws:3.3.1:jar -DoutputDirectory=./spark/jars
mvn dependency:copy -Dartifact=com.amazonaws:aws-java-sdk-bundle:1.11.901:jar -DoutputDirectory=./spark/jars

sudo mv ./spark-jars/*.jars $SPARK_HOME/jars
rm -rf ./spark-jars