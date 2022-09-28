# Rusty Cannon

An attempt to create a rust build configuration that is compatible with the MIPS execution environment for [Optimism Cannon](https://github.com/ethereum-optimism/cannon)

## Concepts

The output of the build should have a bunch of non-conventional properties:

- Target BigEndian MIPS architecture (tick!)
- Syscalls mapped in a particular way
- Memory mapped in the way expected by the host (including I/O and registers)
- Other stuff..

Expect this section to expand as I learn more

## Build Requirements

```shell
rustup install nightly-2022-09-26 # I haven't tried all versions of nighty but this is the only one I've had any luck with
rustup component add rust-src --toolchain nightly-2022-04-24
```


## This was helpful

```shell
wget http://download.angelcam.com/toolchains/mips-buildroot-linux-gnu.tar.gz
tar xzf mips-buildroot-linux-gnu.tar.gz
export PATH=$(pwd)/mips-buildroot-linux-gnu/usr/bin:$PATH
export CC_mips_unknown_linux_gnu=mips-buildroot-linux-gnu-gcc
```

## This may also be helpful

Followed by a horrifyingly large number of libs. But the key line is at the bottom.

/home/justin/repos/althea_rs/target/mips-unknown-linux-musl/debug/deps/libminiz_sys-9df090e5aeaaf6af.rlib: error adding symbols: File in wrong format

Oh no, an x86 library has found it’s way into our mips linking operation! Cargo was building and linking for the right platform but somehow those flags got ignored for some subset of the libraries.

Crates like cc-rs are used to link external C or C++ libraries into Rust programs at compile time. You might notice that the popular rust-openssl crate uses this method to link against the system OpenSSL.

It’s not enough to tell Cargo what to compile for, you must also let cc-rs know that it’s cross compiling and rust-openssl needs to know where the target OpenSSL headers are located.

#!/bin/bash
export CARGO_TARGET_MIPS_UNKNOWN_LINUX_MUSL_LINKER=/home/justin/repos/althea-firmware/build/staging_dir/toolchain-mips_24kc_gcc-5.5.0_musl/bin/mips-openwrt-linux-gcc
export TARGET_CC=/home/justin/repos/althea-firmware/build/staging_dir/toolchain-mips_24kc_gcc-5.5.0_musl/bin/mips-openwrt-linux-gcc
export HOST_CC=gcc
export MIPS_UNKNOWN_LINUX_MUSL_OPENSSL_DIR=/home/justin/repos/althea-firmware/build/staging_dir/target-mips_24kc_musl/usr/
export PKG_CONFIG_ALLOW_CROSS=1cargo build --target mips-unknown-linux-musl --release

Notice how in this build script we not only specify CARGO_TARGET but also TARGET_CC and HOST_CC which are read by cc-rs to determine what to compile for where. Finally we specify the OPENSSL_DIR for our target architecture. This script can be simplified some, but is useful to illustrate all the moving parts clearly.

## Trying musl now to get a fully static link

http://musl.cc/mips-linux-musl-cross.tgz


```shell
wget http://musl.cc/mips-linux-musl-cross.tgz
tar xzf mips-linux-musl-cross.tar.gz
export PATH=$(pwd)/mips-linux-musl-cross/usr/bin:$PATH
export CC_mips_unknown_linux_musl=mips-linux-musl-cross-gcc
```

### Thanks Steve Klabnik 

https://stackoverflow.com/questions/31770604/how-to-generate-statically-linked-executables