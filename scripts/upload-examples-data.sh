#!/usr/bin/env bash

set -e

BASEDIR=$(dirname $0)

# Create bucket for examples
mc mb -p minio/datalake

# Extract and upload data
unzip -o -d $BASEDIR/../resources/data  $BASEDIR/../resources/data.zip

pushd $BASEDIR/../resources/data
mc cp ./* minio/datalake/examples/
popd

rm -rf $BASEDIR/../resources/data