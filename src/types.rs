#[cfg(not(target_arch = "x86_64"))]
pub enum Boolean {
    False = 0,
    True = 0x02,
}

#[cfg(target_arch = "x86_64")]
pub enum Boolean {
    False = 0,
    True = 0x14,
}

