# GCW-Dosbox

A tiny wrapper POSIX shell script that allows running dosbox with
game-specific configuration file.

## Problem

There is currently no way to run Dosbox using game-specific
configuration file. It's crucial because a game
may require special emulation configuration to
run smoothly; also, some games require additional
mounts that have to be set up before game is launched
in order to work properly.

## Solution

Solution is very simple. Create a shortcut which will execute `gcw-dosbox.sh` script by passing a game-specific configuration file
path as an argument (like `gcw-dosbox -c "/path/to/my/configuration/file"`) and it will do following:

- back up dosbox global configuration file (by default `~/.dosbox/dosbox-SVN.conf)

- replace global configuration file with the custom file

- run dosbox (which will in turn run all commands specified in `[autoexec]` directive of game configuration file, so in other words it can launch the game immediately)

- restore the configuration file so that next time dosbox will be executed it's state will be normal
