#!/usr/bin/env bash

export CQLSH_HOST=172.16.10.25
#put your cqlsh bin path here!
export CQLSH_PATH=/Users/georgeli/lib/cas-3.0.8

bash $CQLSH_PATH/bin/cqlsh

################

bin/nodetool --host 172.16.10.25 cfstats

COPY $TABLE TO '/dev/null/';

COPY $TABLE TO '/dev/null/';
