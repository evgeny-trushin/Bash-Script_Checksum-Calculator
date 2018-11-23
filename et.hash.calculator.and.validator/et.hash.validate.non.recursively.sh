#!/usr/bin/env bash
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )/
. ${PARENT_PATH}/et.hash.settings.sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
if [[ ! -f "${CHECKSUM_FILE_PATH}" ]]; then
    echo The file "${CHECKSUM_FILE_PATH}" does not exist.
    mv "${FILE_OK}" "${FILE_ERROR}" 2>/dev/null
    echo Hash file does not exist: ${DATE}>>"${FILE_ERROR}"
else
    if [[ "${DEBUG}" = "true" ]]; then
        echo
        echo FILE_PATH: ${FILE_PATH}
        echo
    fi
    ORIGINAL_HASH=`cat "${CHECKSUM_FILE_PATH}" | ${HASH_TYPE}`
    CALCULATED_HASH=`. ${PARENT_PATH}et.hash.calculate.sh | ${HASH_TYPE}`
    if [[ ! -z "$CALCULATED_HASH" && "$ORIGINAL_HASH" == "$CALCULATED_HASH" ]]; then
        mv "${FILE_ERROR}" "${FILE_OK}" 2>/dev/null
        echo OK HASH: "${CALCULATED_HASH}" ${DATE}>>"${FILE_OK}"
        echo OK: "${CHECKSUM_FILE_PATH}"
    else
        mv "${FILE_OK}" "${FILE_ERROR}" 2>/dev/null
        echo ERROR HASH: ${CALCULATED_HASH} ${DATE}>>"${FILE_ERROR}"
        echo ERROR: "${CHECKSUM_FILE_PATH}"
        if [[ "${DEBUG_OUTPUT_HASH}" = "true" ]]; then
            echo
               echo "${ORIGINAL_HASH}" :original
               echo "${CALCULATED_HASH}" :calculated
            echo
        fi
        echo
    fi
fi
