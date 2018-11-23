#!/usr/bin/env bash
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )/
. ${PARENT_PATH}/et.hash.settings.sh
CALCULATED_HASH=$(find "${FILE_PATH}" -maxdepth 1 -type f ${IGNORE_FILES} | while read FILE
do
    CALCULATED_HASH=$(basename "${FILE}" | "${HASH_TYPE}" &)
    echo -e ${CALCULATED_HASH} `basename "${FILE}"`
done | sort -n -t = -k 2)
wait
echo -e "${CALCULATED_HASH}"