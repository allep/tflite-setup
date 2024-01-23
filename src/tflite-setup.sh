#!/bin/bash

TFLITE_REPO_URL="git@github.com:tensorflow/tflite-micro.git"

# Internal state

INSTALL_TARGET_DIR=""
INSTALL_MODE="false"

# Functions
tflite_repo_setup() {
    if [[ "$INSTALL_MODE" == "true" ]]; then
        git clone "$TFLITE_REPO_URL" "$INSTALL_TARGET_DIR"
    fi
}

check_script_params() {
    while getopts "i:" o; do
        case "${o}" in
            i)
                INSTALL_MODE="true"
                INSTALL_TARGET_DIR=${OPTARG}
                ;;
        esac
    done
}

print_script_status() {
    echo "Running script with:"
    echo "INSTALL_MODE:             ${INSTALL_MODE}"
    echo "INSTALL_TARGET_DIR:       ${INSTALL_TARGET_DIR}"
}

# Actual script
check_script_params $@
print_script_status

tflite_repo_setup

