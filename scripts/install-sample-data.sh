#!/usr/bin/env bash

set -e

BASEDIR=$(dirname $0)

#
# MinIO Example
#
# Create bucket for examples
mc mb -p minio/datalake

# Extract and upload data
unzip -o -d $BASEDIR/../resources/data  $BASEDIR/../resources/data.zip

pushd $BASEDIR/../resources/data
mc cp ./* minio/datalake/examples/
popd

rm -rf $BASEDIR/../resources/data

#
# MySQL Example
# 
unzip -o -d $BASEDIR/../resources $BASEDIR/../resources/mysqlsampledatabase.zip
mysql -e 'drop database if exists classicmodels'
mysql < $BASEDIR/../resources/mysqlsampledatabase.sql
rm $BASEDIR/../resources/mysqlsampledatabase.sql