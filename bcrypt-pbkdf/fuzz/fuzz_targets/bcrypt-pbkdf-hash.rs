#![no_main]

use libfuzzer_sys::fuzz_target;
use bcrypt_pbkdf::PasswordHash;

fuzz_target!(|data: &[u8]| {
    let sting = String::from_utf8_lossy(data);
    let _ = PasswordHash::new(&sting);
});