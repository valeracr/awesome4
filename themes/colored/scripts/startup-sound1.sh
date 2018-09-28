#!/bin/sh

exec $( mplayer $HOME/.config/awesome/themes/colored/sounds/Login.wav ) && systemctl reboot

exit 0
