#!/usr/bin/env bash
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )/
. ${PARENT_PATH}/et.hash.settings.sh
if [[ "${OVERRIDE_HASH_IF_AN_ERROR}" = "true" && -f "${FILE_ERROR}" ]]; then
    OVERRIDE_HASH=true
    mv "${FILE_ERROR}" "${FILE_OK}" 2>/dev/null
    echo NEW HASH WAS CALCULATED ${DATE}>>"${FILE_OK}"
fi

if [[ "${OVERRIDE_HASH}" = "true" || ! -f "${CHECKSUM_FILE_PATH}" ]]; then
    CALCULATED_HASH=`. ${PARENT_PATH}et.hash.calculate.sh`
    if [[ "${DEBUG}" = "true" ]]; then
        echo
        echo CALCULATED_HASH: ${CALCULATED_HASH}
        echo
    fi
    if [[ ! -z "$CALCULATED_HASH" ]]; then
        echo -e "${CALCULATED_HASH}"> "${CHECKSUM_FILE_PATH}"
        echo "${CHECKSUM_FILE_PATH}" was created.
        if [[ "${DEBUG_OUTPUT_HASH}" = "true" ]]; then
            echo
            echo new hash: "${CALCULATED_HASH}"
            echo
        fi
    else
        echo CALCULATED_HASH: ${CALCULATED_HASH} is empty in "${CHECKSUM_FILE_PATH}"
    fi
else
    echo The hash exists: "${CHECKSUM_FILE_PATH}"
fi
