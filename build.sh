#!/bin/bash

function compile() 
{
    source ~/.bashrc  # Only source if necessary
    export USE_CCACHE=1
    ccache -M 100G
    export ARCH=arm64
    export KBUILD_BUILD_HOST=RYZEN-RIPPER
    export KBUILD_BUILD_USER=IamCOD3X
    export LOCALVERSION=-ViP3R🐍-v1.0-REBOOTED

    # Define Clang directory
    export CLANG_DIR="/home/ripper/Desktop/OS/KERNEL_STUFF/ToolChains/proton-clang"

    # Check if Clang is already cloned
    if [ ! -d "$CLANG_DIR" ]; then
        git clone --depth=1 https://github.com/Kdrag0n/proton-clang.git "$CLANG_DIR"
    fi

    export PATH="$CLANG_DIR/bin:${PATH}"

    # Ensure 'out' directory exists
    mkdir -p out

    make O=out ARCH=arm64 onclite-perf_defconfig

    make -j$(nproc --all) O=out \
                          ARCH=arm64 \
                          CC="clang" \
                          LD=ld.lld \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE="$CLANG_DIR/bin/aarch64-linux-gnu-" \
                          CROSS_COMPILE_ARM32="$CLANG_DIR/bin/arm-linux-gnueabi-" \
                          CONFIG_NO_ERROR_ON_MISMATCH=y
}

compile
