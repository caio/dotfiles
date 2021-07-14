#!/bin/bash
# XXX This will be called by acpid as root.
# Replaces /etc/acpi/handler.sh

function log {
    logger -t "CAIO" $@
}

case "$1" in
    button/f20)
        log "EFF TWENTY $2 $3 $4"
        ;;
    button/volumeup)
        # XF86AudioRaiseVolume
        ;;
    button/volumedown)
        # XF86AudioLowerVolume
        ;;
    button/mute)
        # XF86AudioMute
        ;;
    video/brightnessup)
        # XF86MonBrightnessUp, but xbacklight doesn't work
        brightnessctl s +10
        ;;
    video/brightnessdown)
        # XF86MonBrightnessDown, but xbacklight doesn't work
        brightnessctl s 10-
        ;;
    video/switchmode)
        # XF86Display
        ;;
    ibm/hotkey)
        case "$2 $3" in
            "LEN0268:00 00000080")
                case "$4" in
                    00001317)
                        log "BALLON"
                        ;;
                    00001318)
                        log "PHONE ON"
                        ;;
                    00001319)
                        log "PHONE OFF"
                        ;;
                    00001311)
                        # XF86Favorites
                        ;;
                    *)
                        log "Unknown ibm/hotkey dollar four: $4"
                        ;;
                esac
                ;;
            *)
                log "Unhandled ibm/hotkey action: $2 / $3 / $4"
                ;;
        esac
        ;;
    *)
        log "Unhandled ACPI: $@"
        ;;
esac
