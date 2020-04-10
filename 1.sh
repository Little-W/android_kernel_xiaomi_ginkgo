mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
export PATH=${PWD}/toolchain/bin:$PATH 
export LD_LIBRARY_PATH=${PWD}/toolchain/lib:$LD_LIBRARY_PATH 
export RANLIB=/bin/true
make O=out ARCH=arm64 vendor/ginkgo-perf_defconfig
PATH="${PWD}/bin:${PWD}/toolchain/bin:${PATH}" \
make -j$(nproc --all) O=out -o3 \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                      CROSS_COMPILE=aarch64-linux-gnu- | tee kernel.log
