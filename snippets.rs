// Ignore warnings during development:
#![cfg_attr(debug_assertions, allow(dead_code, unused_imports))]
#![cfg_attr(debug_assertions, allow(dead_code, unused_mut))]
#![cfg_attr(debug_assertions, allow(dead_code, unused_variables))]
#![cfg_attr(debug_assertions, allow(dead_code, unreachable_code))]
#![allow(clippy::needless_return)]

// Opt out of rustfmt for a piece of code:
#[rustfmt::skip]
// old syntax:
#[cfg_attr(rustfmt, rustfmt::skip)]

// https://doc.rust-lang.org/reference/tokens.html#raw-string-literals
// Escape JSON string:
println!("data = {:?}", r#"{"text":"Hello, World!"}"#);

// Sleep:
std::thread::sleep(std::time::Duration::from_millis(1000));

// Measure time elapsed:
let now = std::time::Instant::now();
std::thread::sleep(std::time::Duration::from_millis(1234));
println!("time elapsed: {}", now.elapsed());

// Upgrade rust
rustup up

// Add components
rustup component add rust-analyzer

// Upgrade dependencies in Cargo.toml
cargo install cargo-edit
cargo upgrade --dry-run
cargo upgrade

// List a crates' available features
cargo install cargo-feature
cargo feature reqwest
