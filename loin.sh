#!/bin/bash

function bookmarksAsJson {
	buku -p -j
}

function joinJsonContent {
	jq '.[] | .title + "|" + .tags + "|" + .uri'
}

function limitColumnWidth {
	awk 'BEGIN {FS = "|"}
	{
		print substr($1, 2, 30), "|", substr($2, 1, 30), "|", substr($3, 1, 30)
	}'
}

function alignColumns {
	column -t -s "|"
}

function searchBookmarks {
	bookmarksAsJson |
	joinJsonContent |
	limitColumnWidth |
	alignColumns |
	peco
}

function extractUrl {
	egrep -o 'https?://[^ ]+'
}

selectedUrl=$(searchBookmarks | extractUrl)
 
if [ -n "$selectedUrl" ];then
	xdg-open $selectedUrl
fi
