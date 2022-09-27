
## Build Requirements

```shell
rustup install nightly-2022-09-26 # I haven't tried all versions of nighty but this is the only one I've had any luck with
rustup component add rust-src --toolchain nightly-2022-04-24
```

## Goals

According to the Optimism/Cannon repo the aim is to produce a binary that is "run and mapped at 0x0"

Need to figure out how to use llvm-objcopy to do that, possibly with a custom script like Cannon did for Minigeth