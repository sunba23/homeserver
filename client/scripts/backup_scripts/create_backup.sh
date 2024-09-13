#!/bin/bash

# This script creates a backup of your system on a remote server

source ../../VARIABLES
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE=backup-$DATE.tar.gz

# Construct the rsync include options
INCLUDE_OPTS=""
for item in "${INCLUDE_ITEMS_HOME[@]}"; do
    INCLUDE_OPTS+=" $HOME/$item"
done
for item in "${INCLUDE_ITEMS_NON_HOME[@]}"; do
    INCLUDE_OPTS+=" $item"
done

# Create tarball and send it to server; Delete local backup file
tar -cvpzf $BACKUP_FILE $INCLUDE_OPTS
rsync -avzP $BACKUP_FILE $SSH_USER@$SSH_ADDRESS:$BACKUP_DIR/$BACKUP_FILE
rm -f $BACKUP_FILE

# Keep only the latest backup
ssh $SSH_USER@$SSH_ADDRESS "cd $BACKUP_DIR && ls -t | tail -n +2 | xargs rm -rf"
