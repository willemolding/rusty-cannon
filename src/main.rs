#![no_main]
#![feature(restricted_std)]

use mips_rt::entry;

#[entry]
fn main() -> ! {
    loop {}
}
