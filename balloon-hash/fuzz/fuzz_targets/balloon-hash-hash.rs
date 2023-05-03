#![no_main]

use libfuzzer_sys::fuzz_target;
use balloon_hash::PasswordHash;

fuzz_target!(|data: &[u8]| {
    let sting = String::from_utf8_lossy(data);
    let _ = PasswordHash::new(&sting);
});