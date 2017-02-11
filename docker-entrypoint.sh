#!/bin/sh

export PGDATA=/data 
export FILE_MARK=$PGDATA/fileflag


## This commands are only executed if $FILE_MARK doesn't exist.
#
if [ ! -f $FILE_MARK ]
then

    # Set the permission of postgres directory
    chown -R postgres:postgres $PGDATA   
    
     # Create initial database
    gosu postgres initdb
    
    # Allow all hosts 
    echo "host  all   all   0.0.0.0/0   trust" >> /data/pg_hba.conf

    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf
  
fi

if [ ! -f $FILE_MARK ]
then
     echo "host  all   all   0.0.0.0/0   trust" >> /data/pg_hba.conf
     touch $FILE_MARK
fi

## Start postgres database server process
#
gosu postgres postgres -D /data -c config_file=/data/postgresql.conf
