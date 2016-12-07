#! /bin/awk -f

# take a line containing a "↓"-separated string like
# best title↓worst tag, mediocre tag↓https://someurl↓42
# to a column format like
# best title        | worst tag, mediocre tag           | someurl\0https://someurl|42
# parts after the null byte are interpreted by peco as text that is not to be shown
# but only returned

BEGIN {
	FS = "↓"
	titleColumnWidth = 40
	tagColumnWidth = 30
}

{	
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
