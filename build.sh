#!/usr/bin/env bash
set -e

TARGET=mips-unknown-linux-musl

# build for MIPS target and
# also build the standard lib and a memory manager so there are no host requirements
cargo +nightly-2022-09-26 build --release --target $TARGET

cp ./target/$TARGET/release/rust-mips .
file rust-mips

if [[ ! -d venv ]]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip3 install -r requirements.txt
./compile.py rust-mips
deactivate