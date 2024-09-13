#!/bin/bash
source ../../VARIABLES
rsync -azP $SSH_USER@$SSH_ADDRESS:~/$SYNC_FOLDER~
