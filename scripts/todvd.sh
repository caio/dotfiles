#!/bin/bash

mencoder -of mpeg -mpegopts format=dvd:tsaf -ovc lavc -oac lavc -vf harddup -srate 48000 -af lavcresample=48000 -lavcopts vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vstrict=0:vbitrate=8000:keyint=12:aspect=4/3:trell:mbd=2:precmp=2:subcmp=2:cmp=2:dia=-10:predia=-10:cbp:mv0:vqmin=1:lmin=1:dc=10:acodec=ac3:abitrate=192 -ofps 30000/1001 "$1" -sub "$2" -o MyMovie.mpg
