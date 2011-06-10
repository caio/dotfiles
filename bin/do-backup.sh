#!/bin/bash

duplicity --ssh-options="-oProtocol=2 -oIdentityFile=/home/rcaio/.ssh/id_dsa" $* ~/etc/Dropbox/mail scp://romao@pokgsa.ibm.com/mailbackup
