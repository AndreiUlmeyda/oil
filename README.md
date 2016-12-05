# loin
Search-as-you-type cli frontend for the [buku](https://github.com/jarun/Buku) bookmarks manager using [peco](https://github.com/peco/peco). It runs on Linux and inside your favourite terminal emulator.

[![loin-demo.gif](https://s13.postimg.org/ph4t1fchz/loin_demo.gif)](https://postimg.org/image/snzcl1wxv/)

## features
* View a list of your (buku managed) bookmarks and their tags and titles in your terminal
* While typing, have the list instantaneously filtered accordingly
* After selecting one (hit Enter) or multiple bookmarks (read below), have them opened in your browser
* Tag-Mode: After selecting the bookmarks, get prompted for a tag and have it applied to all of them.
* Title-Mode: After selecting the bookmarks, get prompted for a new title for each one.
* Delete-Mode: After selecting the bookmarks, delete each one.

## basic usage
After cloning the repository, navigate to it's folder, make sure the three scripts are executable and simply invoke loin inside a terminal like so

`./loin`

start typing and hit enter when you found what you were looking for (the latter  being great life advice, too).

## a bit more streamlined usage
**Set up an alias** for your shell. Refer to your shell's manual on how to do that. If you do not know off of the top of your cat which one you are using, try entering `ps -p $$` into your terminal and hit enter. The end of the second line, for instance "zsh" or "csh", should tell you what term to throw in the general direction of google to get you on track.

Quicker to access yet, **set up a hotkey using your window manager**. I can only outline a solution for one (mine) particular setup since the diversity of desktop environments is great. Using the window manager "awesome wm" I register a hotkey to execute something like

`urxvt -e "<path-to-loin>/loin"`

Or even

`urxvt -name bookmarkViewer -e "<path-to-loin>/loin"`

in which case the 'instance' property of it's window is set to 'bookmarkViewer' and can now be referred to in the 'rules' section of your awesome wm config to have it opened in any special way you like (I have it popup fullscreen).

Customize your peco config to, *no offense peco, you know I love you and all but*, make it look nice. And **enable** it's feature **to select multiple lines at once**. For the latter you need to consult the peco README and then add to your config something like

`"StickySelection": true`
    
to enable multiple selection, and

` "Action": {
    	"selectAndMoveDown": [
    		"peco.ToggleSelection",
    		"peco.SelectDown"
    	]
    }
`
    
together with

`"Keymap": {
    	"C-Space": "selectAndMoveDown",
    	"ArrowLeft": "peco.ScrollLeft",
    	"ArrowRight": "peco.ScrollRight"
    }
}
`

to make multiple selection as easy as hitting "Ctrl+Space" a bunch of times and enable you to scroll left and right in case you want a glimpse of your urls on the right.

## dependencies
* [buku](https://github.com/jarun/Buku)
* [peco](https://github.com/peco/peco)
* [jq](https://github.com/stedolan/jq)

## disclaimer
You wish! I'll never give back a god damned thing I've claimed. But, really, I think it likely that you will run into issues regarding the length of the titles and tags of your bookmarks and the width of your terminal in your favourite use case. Write me an issue and we will, together, iron out the best compromise or configuration option. For the moment, if you have that problem and feel adventurous, take a look at the awk script itself (the scripts are tiny compared to the wall of text you just scaled) and look at the two lines setting up `printf` near the end. Fuck around with them and the variables specifying the column widths until the result pleases you. Good luck, my friend.

## lore
While seemingly immature at first glans, this tool was given a short name that is easy to remember and type. Notice the small, smooth outward spiral you have to inscribe with your fingers during invocation and compare it to the wandering all across keyboard land in a fever dream that peco and others suffer your troubled hands to do. All this while honoring Lóin, Gimli's long lost brother become high librarian of Thorins Halls. Lóin, fruit of the loins of Glóin, son of Gróin. Genitals.
