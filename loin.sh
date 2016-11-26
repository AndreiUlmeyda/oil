#!/bin/bash

function bookmarksAsJson {
	buku -p -j
}

# join all bookmark properties into one line
function joinJsonContent {
	jq '.[] | .title + "|" + .tags + "|" + .uri'
}

# cut off each column at a fixed width (awk is probably a bad choice,
# use simpler tools)
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

# run everything and store peco output
selectedUrl=$(searchBookmarks | extractUrl)

# open in browser if an url was found
if [ -n "$selectedUrl" ];then
	xdg-open $selectedUrl
fi
