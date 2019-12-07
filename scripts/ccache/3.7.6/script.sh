#!/usr/bin/env bash

MASON_NAME=ccache
MASON_VERSION=3.7.6
MASON_LIB_FILE=bin/ccache

. ${MASON_DIR}/mason.sh

function mason_load_source {
    mason_download \
        https://github.com/${MASON_NAME}/${MASON_NAME}/releases/download/v${MASON_VERSION}/${MASON_NAME}-${MASON_VERSION}.tar.gz \
        00487a4e9045fc44d67275c37f3cf3b318d9fbea

    mason_extract_tar_gz

    export MASON_BUILD_PATH=${MASON_ROOT}/.build/${MASON_NAME}-${MASON_VERSION}
}

function mason_compile {
    # Add optimization flags since CFLAGS overrides the default (-g -O2)
    export CFLAGS="${CFLAGS} -O3 -DNDEBUG"
    ./configure \
        --prefix=${MASON_PREFIX} \
        ${MASON_HOST_ARG} \
        --with-bundled-zlib
    make V=1 -j${MASON_CONCURRENCY}
    make install
}

function mason_ldflags {
    :
}

function mason_cflags {
    :
}

function mason_clean {
    make clean
}

mason_run "$@"
