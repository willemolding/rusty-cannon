
## Build Requirements

```shell
rustup install nightly-2021-01-26 # I haven't tried all versions of nighty but had trouble with latest..
rustup default nightly-2021-01-26
rustup component add rust-src
rustup component add llvm-tools-preview
```

## Goals

According to the Optimism/Cannon repo the aim is to produce a binary that is "run and mapped at 0x0"

Need to figure out how to use llvm-objcopy to do that, possibly with a custom script like Cannon did for Minigeth