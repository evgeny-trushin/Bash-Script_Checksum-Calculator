#!/usr/bin/env bash
TIME_START=`date +%s`
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )/
. ${PARENT_PATH}/et.hash.settings.sh
find "${FILE_PATH}" -d | while read DIR
do
    if test -d "${DIR}"
    then
        . ${PARENT_PATH}et.hash.validate.non.recursively.sh "${DIR}"
    fi
done
TIME_END=`date +%s`
RUNTIME=$((TIME_END-TIME_START))
echo
echo RUNTIME: ${RUNTIME} sec.
echo