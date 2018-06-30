#!/usr/bin/env bash
# This processor performs BASH expansion on a text template
MY_DIR="${0%/*}"
TMP_DIR="${MY_DIR}/tmp"
OUTPUT_DIR="${MY_DIR}/output"
SUFFIX="json"

processJson() {
    FILE_IDENTIFIER="$1"
    cleanUp
    createDirectories
    ( echo "cat <<EOF >${OUTPUT_DIR}/final.${SUFFIX}";
    cat ${FILE_IDENTIFIER}template.${SUFFIX};
    echo "EOF";
    ) >"${TMP_DIR}"/temp.${SUFFIX}

    . "${TMP_DIR}"/temp.${SUFFIX}
    rm "${TMP_DIR}"/temp.${SUFFIX}
    cat "${OUTPUT_DIR}"/final.${SUFFIX}
}

createDirectories() {
    mkdir -p "${TMP_DIR}"
    mkdir -p "${OUTPUT_DIR}"
}

cleanUp() {
    rm -f "${OUTPUT_DIR}"/final.${SUFFIX} "${TMP_DIR}"/*
}

processJson "$1"
