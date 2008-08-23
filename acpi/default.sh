#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

if [ "$group" = "ibm" ]
then
    key="$2"\ "$3"\ "$4"
fi

log_unhandled() {
	logger "ACPI event unhandled: $*"
}

case "$group" in
	button)
		case "$action" in
			power)
				/sbin/init 0
				;;

			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			#lid)
			#	xset dpms force off
			#	;;

			*)	log_unhandled $* ;;
		esac
		;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			*0)
				cpufreq-set -c 0 -g powersave
                cpufreq-set -c 1 -g powersave
				;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			*1)
				cpufreq-set -c 1 -g ondemand
				cpufreq-set -c 1 -g ondemand
				;;

			*)	log_unhandled $* ;;
		esac
		;;

    ibm)
        case "$action" in
            hotkey)
                case "$key" in
                    "HKEY 00000080 00001010")
                        echo up > /proc/acpi/ibm/brightness
                        ;;
                    "HKEY 00000080 00001011")
                        echo down > /proc/acpi/ibm/brightness
                        ;;
                    "HKEY 00000080 00001005")
                        bluetooth=`head -n 1 /proc/acpi/ibm/bluetooth | awk '{print $2}'`
                        case "$bluetooth" in
                            disabled)
                                echo enable > /proc/acpi/ibm/bluetooth
                                ;;
                            enabled)
                                echo disable > /proc/acpi/ibm/bluetooth
                                ;;
                            esac
                        ;;
                    "HKEY 00000080 00001004")
                        echo 3 > /proc/acpi/sleep
                        ;;
                    "HKEY 00000080 00001002")
                        /usr/kde/3.5/bin/dcop --all-sessions --all-users kdesktop KScreensaverIface lock
                        ;;
                    "HKEY 00000080 00001018")
                        /usr/kde/3.5/bin/dcop --all-sessions --all-users ksmserver default logout 0 0 0
                        /sbin/shutdown -h now "ThinkVantage button pressed"
                        ;;
                    *)
                        log_unhandled $* ;;
                esac
                ;;
            *) log_unhandled $* ;;
        esac
        ;;

	*)	log_unhandled $* ;;
esac
