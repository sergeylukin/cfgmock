#!/bin/sh

# Absolute path to this script's current working directory
CURRENT_DIR="$( cd $(dirname $0) ; pwd -P )"

# Get absolute path to the `cfgmock` binary
CFGMOCK="$(cd $CURRENT_DIR/../bin; pwd -P)/cfgmock.sh"

CUSTOM_CFG_PATH="$CURRENT_DIR/custom.conf"
PROGRAM_CFG_PATH="$CURRENT_DIR/program.conf"
MERGED_CFG_PATH="$CURRENT_DIR/merged.conf"

# Test incremental override
OUTPUT="$($CFGMOCK --custom-cfg $CUSTOM_CFG_PATH \
                   --program-cfg $PROGRAM_CFG_PATH \
                   --execute cat\ $PROGRAM_CFG_PATH \
                   --strategy incremental)"
EXPECTED_OUTPUT="$(cat $MERGED_CFG_PATH)"

if [ "$OUTPUT" == "$EXPECTED_OUTPUT" ]; then
  echo "Incremental mock test passed"
else
  echo "Incremental mock test failed"
  echo "CFGMOCK OUTPUT:\n$OUTPUT\n\n"
  echo "EXPECTED OUTPUT:\n$EXPECTED_OUTPUT\n\n"
  exit 1
fi

# Test full override
OUTPUT="$($CFGMOCK --custom-cfg $CUSTOM_CFG_PATH \
                   --program-cfg $PROGRAM_CFG_PATH \
                   --execute cat\ $PROGRAM_CFG_PATH \
                   --strategy full)"
EXPECTED_OUTPUT="$(cat $CUSTOM_CFG_PATH)"

if [ "$OUTPUT" == "$EXPECTED_OUTPUT" ]; then
  echo "Full mock override test passed"
else
  echo "Full mock override test failed"
  echo "CFGMOCK OUTPUT:\n$OUTPUT\n\n"
  echo "EXPECTED OUTPUT:\n$EXPECTED_OUTPUT\n\n"
  exit 1
fi
