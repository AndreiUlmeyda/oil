#!/bin/bash

urlFromClipboard=$(xsel)

if [[ -n "$urlFromClipboard" ]]; then
	echo "$urlFromClipboard"
	read -p "Create a new bookmark using the above as URL? (y/n):" answer
	case "${answer:0:3}" in
	    y|Y|yes|Yes ) echo "adding..."; buku --add "$urlFromClipboard";;
	    * )   echo "Adding bookmark was cancelled.";;
	esac
else
	echo "Clipboard is empty, not adding any bookmarks."
	exit 0
fi
