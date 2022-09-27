#!/usr/bin/env bash
set -e

# build for MIPS target and
# also build the standard lib and a memory manager so there are no host requirements
RUSTFLAGS="-C target-endian=big"
cargo build --release -Z build-std=core,std,alloc,panic_abort,compiler_builtins -Z build-std-features=compiler-builtins-mem --target mipsel-unknown-none

cp ./target/mipsel-unknown-none/release/rust-mips .
file rust-mips

if [[ ! -d venv ]]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip3 install -r requirements.txt
./compile.py rust-mips
deactivate