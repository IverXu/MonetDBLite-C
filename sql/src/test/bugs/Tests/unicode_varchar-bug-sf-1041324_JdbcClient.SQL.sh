#!/bin/bash

cat << EOF > .monetdb
user=monetdb
password=monetdb
EOF

LC_ALL="`locale -a | grep -i en_us | grep -i utf | head -n 1`"
export LC_ALL

Mlog -x "$MTIMEOUT mjclient -h $HOST -p $MAPIPORT -d ${TSTDB} -f \"$RELSRCDIR/../unicode_varchar-bug-sf-1041324.sql\""

rm -f .monetdb
