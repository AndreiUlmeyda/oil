#!/bin/bash

function bookmarksAsJson {
	buku -p -j
}

# join all bookmark properties into one line
function joinJsonContent {
	jq '.[] | .title + "|" + .tags + "|" + .uri'
}

# fix column width and trim urls
function limitColumnWidth {
	awk 'BEGIN {FS = "|"}
	{
		# omit initial quote, max length 40 chars
		prunedTitle = substr($1, 2, 40)
		# max lenght 40 chars
		prunedTags = substr($2, 1, 40)
		# strip as much as possible from the start of the url
		prunedUrl = gensub("^https?://(w{3}.)?", "", 1, $3)

		print prunedTitle, "|", prunedTags, "|", prunedUrl
	}'
}

function alignColumns {
	column -t -s "|" -o ""
}

function searchBookmarks {
	bookmarksAsJson |
	joinJsonContent |
	limitColumnWidth |
	alignColumns |
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
}

# run peco, store output
selectedUrl=$(searchBookmarks | extractUrl)

# open in browser if it contains a url and try to make up for previously pruned prefix
# WARNING: does not properly restore "https" prefix
if [ -n "$selectedUrl" ];then
	xdg-open http://$selectedUrl
fi
