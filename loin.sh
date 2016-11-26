#!/bin/bash

function bookmarksAsJson {
	buku -p -j
}

function joinJsonContent {
	jq '.[] | .title + " | " + .uri + " | " + .tags'
}

function searchBookmarks {
	bookmarksAsJson | joinJsonContent | peco
}

function extractUrl {
	egrep -o 'https?://[^ ]+'
}

selectedUrl=$(searchBookmarks | extractUrl)
 
if [ -n "$selectedUrl" ];then
	xdg-open $selectedUrl
fi
