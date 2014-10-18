# CFGMOCK

Mocking program configuration made stupidly easy.

**Problem**: It may happen (just happened to me, that's why I created
this project) so that you would want to run a program using different configurations while it always reads from one specific configuration file.

**Solution**: Substitute the common configuration file with the one you
want a program to run against right before program is loaded and rolling back this substitution right after the program was loaded.

*Please note that this solution is not very pretty. It will not work perfectly if being used in multi-user environment or if multiple
instances of program in question are expected to run in parallel.*

## Real use case or why I created this project

I bought [GCW-Zero](http://gcw-zero.com) handheld console, one of the reasons 
is that it's capable of running old DOS games. It turns out, though, [DOSBox for GCW-Zero](https://github.com/dmitrysmagin/dosbox-gcw0/) while being an awesome port doesn't support `-conf` parameter which
allows specifying a configuration file to load when launching dosbox
in other platforms; it's a big gap because in my collection, almost every DOS game has a
`dosbox.conf` file which contains optimized configuration for that game specifically along with a series of game-specific commands which not only perform all the preparations that are required for game to run
as smooth as possible but also launch the game's executable so Ionly setup game configuration once, create a shortcut in form
`dosbox -conf /my/custom/configuration/file` and can run the game anytime by just running
the shortcut without worrying about any prerequistics.

So, using this project, all I need to do in order to run a game
is to create a shortcut on GCW's desktop to a file, that I create in
game's directory, with contents similar to following:

```
#!/bin/sh

# Absolute path to this script's current working directory
CURRENT_DIR=$( cd $(dirname $0) ; pwd -P )
cfgmock --custom-cfg $CURRENT_DIR/dosbox-gcw.conf \
        --program-cfg /media/home/.dosbox/dosbox-SVN.conf \
        --execute opkrun\ /media/data/apps/dosbox.opk \
        --strategy incremental
```

and of course I create a `dosbox-gcw.conf` with incremental configuration overrides/additions.

Note that if you don't want to incrementally override program's configuration but rather fully load your custom configuration
replace `--strategy incremental` with `--strategy full`. Every
game has such file and contents between these files is identical,
only the filename is different.

## Setup

### Automatic installer

Installation can be as easy as running this oneliner under `root` or with `sudo`, depending on your system setup:

```
wget --no-check-certificate https://raw.github.com/sergeylukin/cfgmock/master/tools/install.sh -O - | sh
```

### The manual way

Same result as if automatic installer would run, but manually. Of course, root or `sudo` priviledges required here too (although nothing stops you from installing in any custom way which doesn't require
`root` priviledges):

```
wget --no-check-certificate https://github.com/sergeylukin/cfgmock/archive/master.zip -O cfgmock.zip
unzip cfgmock.zip && rm -f cfgmock.zip
cp ./cfgmock-master/bin/cfgmock.sh /usr/local/bin/cfgmock
chmod +x /usr/local/bin/cfgmock
```

## Uninstall

If used one of the methods explained above, just remove the
`/usr/local/bin/cfgmock` file

## License

Released under [MIT license](http://sergey.mit-license.org/)
