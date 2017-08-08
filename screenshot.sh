#!/bin/bash

## Screenshot tool created by Aetea (https://aetea.me)
## A little bash script to capture and upload screenshots.
## You can find and download it on GitHub
## Link: https://github.com/aetea/screenshot-tool

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $DIR/settings.sh

if [[ "$1" == "help" ]]; then
    echo "Screenshot Tool by Aetea (https://aetea.me) @ https://github.com/aetea/screenshot-tool"
	echo "usage: screenshot.sh [options] [args...]"
	echo "options (name:description):"
	echo "a: capture area"
	echo "w: capture window"
	echo "i: interactive"
	echo "u: upload"
	echo "d <seconds>: delay for the specified amount of time before taking picture"
	echo "p: include the pointer"
	echo "b: include window border"
    echo "c: copy the link to the uploaded image to the clipboard"
	exit 0
fi

FILENAME="$SCREENSHOT_PATH/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"

ARGS="-f $FILENAME"

if [[ "$1" == *"a"* ]]; then
	ARGS="$ARGS -a"
elif [[ "$1" == *"w"* ]]; then
	ARGS="$ARGS -w"
fi

if [[ "$1" == *"i"* ]]; then
	ARGS="$ARGS -i"
fi

if [[ "$1" == *"p"* ]]; then
        ARGS="$ARGS -p"
fi

if [[ "$1" == *"d"* ]]; then
        ARGS="$ARGS --delay=$2"
fi

if [[ "$1" == *"b"* ]]; then
        ARGS="$ARGS -b"
else
	ARGS="$ARGS -B"
fi

gnome-screenshot $ARGS

if ! [ -z ${UPLOAD_PASS+x} ]; then
    SFTP_COMMAND="sshpass -p $UPLOAD_PASS sftp"
elif ! [ -z ${UPLOAD_KEY+x} ]; then
    SFTP_COMMAND="sftp -i $UPLOAD_KEY"
else
    SFTP_COMMAND="sftp"
fi

if [[ "$1" == *"u"* ]]; then
$SFTP_COMMAND -oStrictHostKeyChecking=no -oBatchMode=no -b - $UPLOAD_USER@$UPLOAD_HOST << !
	cd $UPLOAD_PATH
	put $FILENAME
	bye
!
    if [[ "$1" == *"c"* ]]; then
	    echo "$UPLOAD_URL$(basename $FILENAME)" | xclip -selection clipboard
    fi
fi