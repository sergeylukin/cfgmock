#!/bin/sh

# defaults
CUSTOM_CONFIG_PATH=""
GLOBAL_CONFIG_PATH="/media/data/local/home/.dosbox/dosbox-SVN.conf"
DOSBOX_BINARY="opkrun /media/data/apps/dosbox.opk"

usage()
{
cat <<- _EOF_
usage:
  -c your configuration file path
  -g global dosbox configuration file path
  -d dosbox.opk path
  -h this help info
_EOF_
}

if [ "$1" == "" ]; then
  usage
  exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
        -c | --config )         shift
                                CUSTOM_CONFIG_PATH="$1"
                                ;;
        -g | --global )         shift
                                GLOBAL_CONFIG_PATH="$1"
                                ;;
        -d | --dosbox )         shift
                                DOSBOX_BINARY="$1"
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$CUSTOM_CONFIG_PATH" == "" ]; then
  usage
  exit 1
fi

# backup original global configuration file
cp $GLOBAL_CONFIG_PATH "$GLOBAL_CONFIG_PATH.bak"

# override global configuration with custom configuration
echo "$(awk -F= '!a[$1]++' $CUSTOM_CONFIG_PATH $GLOBAL_CONFIG_PATH | grep -v '#' | grep -v '^$')" > $GLOBAL_CONFIG_PATH

# execute dosbox
$DOSBOX_BINARY

# restore the original configuration file
mv "$GLOBAL_CONFIG_PATH.bak" $GLOBAL_CONFIG_PATH
