#![no_std]
#![no_main]
#![cfg_attr(test, feature(custom_test_frameworks))]
#![cfg_attr(test, reexport_test_harness_main = "test_main")]
#![cfg_attr(test, test_runner(agb::test_runner::test_runner))]

#[allow(dead_code)]
mod dungeon;

#[agb::entry]
fn main(mut _gba: agb::Gba) -> ! {
    loop {}
}