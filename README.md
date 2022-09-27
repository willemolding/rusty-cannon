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
