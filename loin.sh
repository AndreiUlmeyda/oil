#!/bin/bash

BASEDIR=$(readlink -f $0 | xargs -r dirname)

function bookmarksAsJson {
	buku -p -j
}

function jsonToLine {
	jq '.[] | .title + "|" + .tags + "|" + .uri'
}

function formatColumns {
	$BASEDIR/format-columns.awk
}

}

function searchBookmarks {
	bookmarksAsJson |
	peco
}

function extractUrl {
	awk '{
		# match from end of line until rightmost whitespace
		urlStart = match($0, "\\S*$")
		# get the substring from previous match, drop last char, which is a "
		url = substr($0, RSTART, RLENGTH-1)
		print url
	}'
	jsonToLine |
	formatColumns |
}

# run peco, store output
selectedUrl=$(searchBookmarks | extractUrl)

# open in browser if it contains a url and try to make up for previously pruned prefix
# WARNING: does not properly restore "https" prefix
if [ -n "$selectedUrl" ];then
	xdg-open http://$selectedUrl
fi
