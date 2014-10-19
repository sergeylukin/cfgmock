#!/bin/sh


#########################
# Defaults
###

STRATEGY="incremental"
CUSTOM_CONFIG_PATH=""
PROGRAM_CONFIG_PATH=""
COMMAND_TO_EXECUTE=""

#########################
# Declare functions
###

usage()
{
cat <<- _EOF_
Usage: $0 [options]

-h| --help         Show this help info

-c|--custom-cfg    Your custom configuration file

-p|--program-cfg   Program's default configuration file
                   It will be overridden/replaced with
                   the configuration keys and values found in
                   custom configuration file, either incrementally
                   or fully, depending on --strategy argument

-e|--execute       Specify a command to execute when configuration
                   file will be ready

-s|--strategy      Specify whether your configuration file should fully
                   replace program's default configuration file ("full")
                   or incrementally ("incremental")
_EOF_
}

if [ "$1" == "" ]; then
  usage
  exit 1
fi


#########################
# Parse passed arguments
###

while [ "$1" != "" ]; do
    case $1 in
        -c | --custom-cfg )     shift
                                CUSTOM_CONFIG_PATH="$1"
                                ;;
        -p | --program-cfg )    shift
                                PROGRAM_CONFIG_PATH="$1"
                                ;;
        -e | --execute )        shift
                                COMMAND_TO_EXECUTE="$1"
                                ;;
        -s | --strategy )       shift
                                STRATEGY="$1"
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done


#########################
# Sanitize variables
###

if [ "$CUSTOM_CONFIG_PATH" == "" ]; then
  usage
  exit 1
fi

if [ "$PROGRAM_CONFIG_PATH" == "" ]; then
  usage
  exit 1
fi

if [ "$COMMAND_TO_EXECUTE" == "" ]; then
  usage
  exit 1
fi

if [ "$STRATEGY" != "incremental" -a "$STRATEGY" != "full" ]; then
  usage
  exit 1
fi


#########################
# Perform the main logic
###

# backup original program's configuration file
cp $PROGRAM_CONFIG_PATH "$PROGRAM_CONFIG_PATH.bak"

if [ "$STRATEGY" == "incremental" ]; then
  # incrementally override program's default configuration with custom configuration
  echo "$(awk -F= '!a[$1]++' $CUSTOM_CONFIG_PATH $PROGRAM_CONFIG_PATH | grep -v '#' | grep -v '^$')" > $PROGRAM_CONFIG_PATH
elif [ "$STRATEGY" == "full" ]; then
  cp $CUSTOM_CONFIG_PATH $PROGRAM_CONFIG_PATH
fi

# execute the command
$COMMAND_TO_EXECUTE

# restore the original configuration file
mv "$PROGRAM_CONFIG_PATH.bak" $PROGRAM_CONFIG_PATH
