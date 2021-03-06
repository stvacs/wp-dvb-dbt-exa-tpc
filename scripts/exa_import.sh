#!/bin/bash
EXA_PORT=$(docker port exa_exasol_1 | grep 'tcp' | grep '8888' | grep -oP '(?<=:)\w+')
#DSN=localhost:$EXA_PORT
DSN=52.143.0.192:8563
USER=sys
PWD=Start123
EXAPLUS=exaplus

$EXAPLUS -c $DSN -u $USER -p $PWD -sql 'create schema if not exists EXA_TOOLBOX;'
for s in `dirname $0`/ddl/bootstrap.sql
do
  $EXAPLUS -c $DSN -u $USER -p $PWD -f $s
done

$EXAPLUS -c $DSN -u $USER -p $PWD -f `dirname $0`/ddl/dvb_cfg_import.sql

