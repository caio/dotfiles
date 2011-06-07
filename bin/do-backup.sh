#!/bin/bash

set -e
gsa_smb_mount -u romao -c pokgsa.ibm.com -m ~/etc/gsa -n
duplicity $* ~/etc/Dropbox/mail/ file:////home/rcaio/etc/gsa/mailbackup
