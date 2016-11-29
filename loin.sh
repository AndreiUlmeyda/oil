#!/bin/bash

BASEDIR=$(readlink -f "$0" | xargs dirname)

function bookmarksAsJson {
	buku -p -j
}

function jsonToLine {
	# put the content into an array while casting  index to string and join its
	# elements using the separator "|"
	jq -r '. | (objects | . |  [.title, .tags, .uri, .index|tostring] | join("|")), (. | arrays | .[] | [ .title, .tags, .uri, .index|tostring] | join("|"))'
}

function formatColumns {
	"$BASEDIR"/format-columns.awk
}

function searchAsYouType {
	peco --null
}

function openInBrowser {
	while read -r selectedUrl; do
		xdg-open "$selectedUrl"
	done
}

function openBookmark {
	bookmarksAsJson |
	jsonToLine |
	formatColumns |
	searchAsYouType |
	openInBrowser
}

openBookmark
