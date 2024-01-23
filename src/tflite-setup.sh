#!/bin/bash

TFLITE_REPO_URL="git@github.com:tensorflow/tflite-micro.git"
BAZEL_BIN="bazelisk-linux-amd64" 
BAZEL_URL="https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/${BAZEL_BIN}"
USER_HOME_BIN="${HOME}/bin"

# Internal state

INSTALL_TARGET_DIR=""
INSTALL_MODE="false"

# Functions

tflite_repo_setup() {
    if [[ "${INSTALL_MODE}" == "true" ]]; then
        git clone "${TFLITE_REPO_URL}" "${INSTALL_TARGET_DIR}"
    fi
}

bazel_setup() {
    if [[ "${INSTALL_MODE}" == "true" ]]; then
        local target_bin="${USER_HOME_BIN}/${BAZEL_BIN}"
        wget -o "${target_bin}" "${BAZEL_URL}" 
        chmod +x "${target_bin}"
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
    echo "Bazel bin path:           ${USER_HOME_BIN}/${BAZEL_BIN}"
}

# Actual script
check_script_params $@
print_script_status

tflite_repo_setup
bazel_setup

