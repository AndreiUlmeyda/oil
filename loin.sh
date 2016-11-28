#!/bin/bash

BASEDIR=$(readlink -f "$0" | xargs dirname)

function bookmarksAsJson {
	buku -p -j
}

function jsonToLine {
	jq -r '.[] | .title + "|" + .tags + "|" + .uri'
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
