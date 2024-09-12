#!/bin/bash
source rsync_vars
rsync -azP $USR@$ADDRESS:~/$FOLDER_NAME ~
