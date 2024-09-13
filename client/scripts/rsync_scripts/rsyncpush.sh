#!/bin/bash
source ../../VARIABLES
rsync -azP ~/$SYNC_FOLDER $SSH_USER@$SSH_ADDRESS:~/
