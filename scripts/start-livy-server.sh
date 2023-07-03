#!/usr/bin/env bash

gp sync-await init-conf-dirs

eval $(gp env -e)

$LIVY_HOME/bin/livy-server