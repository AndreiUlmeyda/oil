#! /bin/awk -f

{
	# set field delimiter
	FS = "|"

	# strip input of leading and trailing double quotes
	gsub(/[(^\")(\"$)]/, "", $0)
	# limit some column widths
	fixedColumnWidth = 40
	prunedTitle = substr($1, 1, fixedColumnWidth)
	prunedTags = substr($2, 1, fixedColumnWidth)
	url = $3
	# strip url of prefixes
	prunedUrl = gensub("^https?://(w{3}.)?", "", 1, url)

	# assemble shell command to format colums
	unformatted = prunedTitle"|"prunedTags"|"prunedUrl
	pipeInput = "echo \"" unformatted "\""
	pipe = " | "
	formatInColumns = "column -t -s \"|\" -o \" \""
	formatShellCommand = pipeInput pipe formatInColumns
	# execute said command
	formatShellCommand | getline formatted

	# append null-byte separated original url for use with
	# pecos --null command line flag
	print formatted "\0" url
}