#!/usr/bin/env bash
# This processor performs BASH expansion on a text template
MY_DIR="${0%/*}"
TMP_DIR="${MY_DIR}/tmp"
OUTPUT_DIR="${MY_DIR}/output"
SUFFIX="json"

processJson() {
    FILE_IDENTIFIER="${1}"
    cleanUp
    createDirectories
    OUTPUT_FILE="${OUTPUT_DIR}/final.${SUFFIX}"
    TMP_FILE="${TMP_DIR}/temp.${SUFFIX}"
    ( printf 'cat <<EOF >"%s"\n' "${OUTPUT_FILE}";
    cat "${FILE_IDENTIFIER}"template.${SUFFIX};
    printf "EOF\n";
    ) >"${TMP_FILE}"
    . "${TMP_FILE}"
    rm "${TMP_FILE}"
    printf "%s:%s output %s:\n" "${0}" "${FUNCNAME}" "${OUTPUT_FILE}" >&2
    cat "${OUTPUT_FILE}"
}

createDirectories() {
    mkdir -p "${TMP_DIR}"
    mkdir -p "${OUTPUT_DIR}"
}

cleanUp() {
    printf "%s:%s\n" "${0}" "${FUNCNAME}" >&2
    find "${OUTPUT_DIR}/final.${SUFFIX}" "${TMP_DIR}" -delete
}

main() {
    processJson "${1}"
}

main "${1}"
