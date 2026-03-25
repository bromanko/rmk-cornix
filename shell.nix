{
  pkgs ? import <nixpkgs> { },
}:

let
  bootstrap-rmk-tools = pkgs.writeShellScriptBin "bootstrap-rmk-tools" ''
    if cargo hex-to-uf2 --help >/dev/null 2>&1; then
      echo "cargo-hex-to-uf2 already available"
    else
      echo "Installing cargo-hex-to-uf2 via cargo install..."
      env -u CARGO_BUILD_TARGET cargo install cargo-hex-to-uf2
    fi
  '';

  setup-rust-toolchain = pkgs.writeShellScriptBin "setup-rust-toolchain" ''
    rustup toolchain install stable \
      --component rust-src \
      --component rustfmt \
      --component llvm-tools \
      --target thumbv7em-none-eabihf
  '';

  build-firmware = pkgs.writeShellScriptBin "build-firmware" ''
    set -euo pipefail
    setup-rust-toolchain
    cargo make build
  '';

  build-hex = pkgs.writeShellScriptBin "build-hex" ''
    set -euo pipefail
    setup-rust-toolchain
    cargo make objcopy-central
    cargo make objcopy-peripheral
  '';

  build-uf2 = pkgs.writeShellScriptBin "build-uf2" ''
    set -euo pipefail
    setup-rust-toolchain
    bootstrap-rmk-tools
    cargo make uf2
  '';
in
pkgs.mkShell {
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
    bootstrap-rmk-tools
    setup-rust-toolchain
    build-firmware
    build-hex
    build-uf2
  ];

  shellHook = ''
    export CARGO_BUILD_TARGET=thumbv7em-none-eabihf
    echo "Entering rmk-cornix nix shell"
    echo "Rust is provided via rustup and rust-toolchain.toml"
    echo "Run: setup-rust-toolchain"
    echo "Compile/test with: build-firmware"
    echo "Generate .hex files with: build-hex"
    echo "Generate .uf2 files with: build-uf2"
  '';
}
