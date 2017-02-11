#!/bin/sh

# Set the permission of postgres directory 
chown -R postgres:postgres $PGDATA 

FILE_MARK=$PGDATA/fileflag

# Create initial database
gosu postgres initdb

if [ ! -f $FILE_MARK ]
then echo "host  all   all   0.0.0.0/0   trust" >> /data/pg_hba.conf
else touch $FILE_MARK
fi

gosu postgres postgres -D /data -c config_file=/data/postgresql.conf
