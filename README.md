# oil
Search-as-you-type cli frontend for the [buku](https://github.com/jarun/Buku) bookmarks manager using [peco](https://github.com/peco/peco). It runs on Linux and inside your favourite terminal emulator.

[![loin-demo.gif](https://s13.postimg.org/ph4t1fchz/loin_demo.gif)](https://postimg.org/image/snzcl1wxv/)

## features
* View a list of your (buku managed) bookmarks and their tags and titles in your terminal
* While typing, have the list instantaneously filtered accordingly
* After selecting one (hit Enter) or multiple bookmarks (read below), have them opened in your browser
* Tag-Mode: After selecting the bookmarks, get prompted for a tag and have it applied to all of them.
* Title-Mode: After selecting the bookmarks, get prompted for a new title for each one.
* Delete-Mode: After selecting the bookmarks, delete each one.
* Add a URL from clipboard to your bookmarks.

## basic usage

    usage: oil [OPTIONS]
        by default, selected bookmarks get openend using the default browser

    options:
      -t, --tag
                run in tag-mode (see features)
      -T, --title
                run in title-mode (see features)
      -d, --delete
                run in delete-mode (see features)
      -a, --add
                add a bookmark from clipboard
      -p, --no-peco-reconfiguration
                do not overwrite the users peco configuration (see section about multiline selection)

      Note: Mind that the four modes are mutually exclusive. If more than one is specified it could
      cause all sorts of mayhem, who knows (the last one applies, but please don't).

## installation
After cloning this repository, make sure the listed dependencies are installed, navigate to it's directory and run `make install`. After that, your terminal should respond very kindly to the command `oil` and as soon as that one gets going you are free as a bird to just start typing away and hit enter when you found what you were looking for (the latter  being great life advice, too).

Note: Packages for specific linux distributions are not published as of yet since this makes sense only after the user base is of order "3 people or more". However, if you are using Arch-Linux and want this package to be tracked by its package manager you can build and install a package manually. For this purpose a file named PKGBUILD resides in the `misc/` directory. If you run `makepkg` inside a direcory where this file is located, a proper Arch-Linux package will be assembled there. The generated package file can then be installed using `sudo pacman -U <generated-package-file>`.

Feel free, though, to write me an issue requesting a package for your distro. And if you know what you are doing, I hereby grant you permission to take matters into your own hands and publish one yourself. Godspeed.

## multiline selection
This is a feature of peco that is not enabled by default. Anticipating that most users will not already be using peco but will want to use the feature and not drudge through a bunch of configuration options, oil enables it by default by passing a custom configuration file to peco. This leads to the users configuration being overruled. Should you want to use your own peco config, disable this behaviour via the flags
`oil -p` or equivalently `oil --no-peco-reconfiguration`

In case you choose to do this but do not have multiline selection enabled in your peco config, read up on the configuration section of peco and amend your config with something like

        {
            ...
            "StickySelection": true,
            "Action": {
                "selectAndMoveDown": [
                    "peco.ToggleSelection",
                    "peco.SelectDown"
                ]
            },
            "Keymap": {
                "C-Space": "selectAndMoveDown",
                "ArrowLeft": "peco.ScrollLeft",
                "ArrowRight": "peco.ScrollRight"
            }
            ...
        }

This makes it so you can hit Ctrl+Space a bunch of times andh select a number of bookmarks quickly and, additionally, use the left and right arrows to scroll to the left and right. Note: Selections persist through changes in the search term.

## a bit more streamlined usage
**Set up an alias** for your shell. Refer to your shell's manual on how to do that. If you do not know off of the top of your cat which one you are using, try entering `ps -p $$` into your terminal and hit enter. The end of the second line, for instance "zsh" or "csh", should tell you what term to throw in the general direction of google to get you on track.

**Or**, quicker to access yet, **set up a hotkey using your window manager**. I can only outline a solution for one particular setup (mine) because of the diversity of desktop environments. Using the window manager "awesome wm" I register a hotkey to execute something like

`urxvt -e "<path-to-oil>/oil"`

Or even

`urxvt -name bookmarkViewer -e "<path-to-oil>/oil"`

in which case the 'instance' property of it's window is set to 'bookmarkViewer' and can now be referred to in the 'rules' section of your awesome wm config to have it opened in any special way you like. In my case it starts fullscreen as seen in the demo motion picture.

## dependencies
* [buku](https://github.com/jarun/Buku)
* [peco](https://github.com/peco/peco)
* [jq](https://github.com/stedolan/jq)
* xsel (optional Linux/X-Server utility used to add bookmarks from clipboard)

## known issues
* I think it likely that you will run into issues regarding the length of the titles and tags of your bookmarks and the width of your terminal in your favourite use case. Write me an issue and we will, together, iron out the best compromise or configuration option. For the moment, if you have that problem and feel adventurous, take a look at the awk script itself and look at the two lines setting up `printf` near the end. Fuck around with them and the variables specifying the column widths until the result pleases you. Good luck, my friend.
* In Delete-Mode: When deleting an URL that is a substring of another one (for instance youtube.com and youtube.com/...) then you will not be able to delete only this one. For now, this will not be fixed (see #17). I advise you to use buku directly in this case.

## lore
Lore is permanently disabled now. He loves his brother, though, so that's a plus.
