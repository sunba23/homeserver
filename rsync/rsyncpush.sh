#!/bin/bash
source rsync_vars
rsync -azP ~/$FOLDER_NAME $USR@$ADDRESS:~/
