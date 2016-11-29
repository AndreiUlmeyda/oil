#! /bin/awk -f

# set field delimiter
BEGIN {FS = "|"}

{
	titleColumnWidth = 40
	tagColumnWidth = 30
	
	# make fields fit intended column widths
	prunedTitle = substr($1, 1, titleColumnWidth)
	prunedTags = substr($2, 1, tagColumnWidth)
	url = $3
	bukuIndex = $4

	# strip url of prefixes
	prunedUrl = gensub("^https?://(w{3}.)?", "", 1, url)

	# format columns and append null-byte separated original url for use with
	# pecos --null command line flag
	NULL="\0"
	columnFormat = " %-" titleColumnWidth "s | %-" tagColumnWidth "s | %s%s %s|%s\n"
	printf columnFormat, prunedTitle, prunedTags, prunedUrl, NULL, url, bukuIndex
}
