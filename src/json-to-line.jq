#!/usr/bin/env jq -fr

# append all values to one line with separator "↓", handle input of either
# single objects or object arrays
def valuesToLine: [.title, .tags, .uri, .index|tostring] | join("↓");

(objects | . |  valuesToLine),
(arrays | .[] | valuesToLine)
