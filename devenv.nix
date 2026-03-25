{ pkgs, ... }:

{
  packages = with pkgs; [
    rustup
    cargo-make
    cargo-binutils
    flip-link
    pkg-config
    xz
    gh
    git
    jj
  ];

  env = {
    CARGO_BUILD_TARGET = "thumbv7em-none-eabihf";
  };

  scripts.bootstrap-rmk-tools.exec = ''
    if cargo hex-to-uf2 --help >/dev/null 2>&1; then
      echo "cargo-hex-to-uf2 already available"
    else
      echo "Installing cargo-hex-to-uf2 via cargo install..."
      env -u CARGO_BUILD_TARGET cargo install cargo-hex-to-uf2
    fi
  '';

  scripts.setup-rust-toolchain.exec = ''
    rustup toolchain install stable \
      --component rust-src \
      --component rustfmt \
      --component llvm-tools \
      --target thumbv7em-none-eabihf
  '';

  scripts.build-firmware.exec = ''
    set -euo pipefail
    setup-rust-toolchain
    cargo make build
  '';

  scripts.build-hex.exec = ''
    set -euo pipefail
    setup-rust-toolchain
    cargo make objcopy-central
    cargo make objcopy-peripheral
  '';

  scripts.build-uf2.exec = ''
    set -euo pipefail
    setup-rust-toolchain
    bootstrap-rmk-tools
    cargo make uf2
  '';

  enterShell = ''
    echo "Entering rmk-cornix dev shell"
    echo "Rust is provided via rustup and rust-toolchain.toml"
    echo "Run: setup-rust-toolchain"
    echo "Compile/test with: build-firmware"
    echo "Generate .hex files with: build-hex"
    echo "Generate .uf2 files with: build-uf2"
  '';
}
