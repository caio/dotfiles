#!/bin/bash

duplicity --ssh-options="-oProtocol=2 -oIdentityFile=/home/romao/.ssh/id_dsa" $* ~/.mail scp://romao@pokgsa.ibm.com/mailbackup
