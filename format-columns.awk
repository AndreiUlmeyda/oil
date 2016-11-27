#! /bin/awk -f

{
	titleColumnWidth = 40
	tagColumnWidth = 30
	
	# set field delimiter
	FS = "|"

	# strip input of leading and trailing double quotes
	gsub(/[(^\")(\"$)]/, "", $0)
	
	# make fields fit intended column widths
	prunedTitle = substr($1, 1, titleColumnWidth)
	prunedTags = substr($2, 1, tagColumnWidth)
	url = $3

	# strip url of prefixes
	prunedUrl = gensub("^https?://(w{3}.)?", "", 1, url)

	# format columns and append null-byte separated original url for use with
	# pecos --null command line flag
	NULL="\0"
	columnFormat = "%-" titleColumnWidth "s %-" tagColumnWidth "s %s %s %s\n"
	printf columnFormat, prunedTitle, prunedTags, prunedUrl, NULL, url
}