# RMK Configuration for Cornix Keyboard

This repository contains an unofficial [RMK](https://rmk.rs/) configuration for
the Cornix keyboard by Jezail Funder. It aims to help users to customize their
own RMK firmware for Cornix, not to replicate the official firmware.

# Features

- It supports all keys and rotary encoders.
- It supports Vial.
- Its Vial layout is roughlly compatible with the official firmware, so you can
  load your existing Vial layout (`.vil` file) without much modification.
  Macros, combos, tap dances, key maps for rotary encoders, and some other
  things may lost or be messed up, so you may still need to reconfigure them.

# Notes

- LED lighting is not supported.
- Optimization on BLE or power consumption is not made.

# Usage

1. Make any changes you want for the firmware.

2. Enter the dev environment:
   ```sh
   nix-shell
   ```
   Or, if you use direnv:
   ```sh
   direnv allow
   ```
   (`.envrc` uses `use nix`, loading `shell.nix`.)

3. Set up the Rust toolchain:
   ```sh
   setup-rust-toolchain
   ```

4. Compile/test the firmware with the helper script:
   ```sh
   build-firmware
   ```

5. To generate `.hex` artifacts locally:
   ```sh
   build-hex
   ```

6. To generate `.uf2` files as well:
   ```sh
   build-uf2
   ```
   This installs `cargo-hex-to-uf2` if needed, then generates the two `.uf2`
   files in the repository root.

   If you prefer the lower-level build steps, you can also run:
   ```sh
   cargo make build
   cargo make objcopy-central
   cargo make objcopy-peripheral
   cargo make uf2
   ```

   A `devenv.nix` is also included, but on this machine `devenv` currently
   aborts before entering the shell, so `shell.nix` is the working fallback.

   Otherwise, fork this repository, go to GitHub Actions tab, tap *Build RMK
   firmware*, and download the artifacts when the build is done.

7. Flash the two `.uf2` files to the left and right halves of the keyboard
   respectively. You may need to delete Bluetooth pairing on your computer first
   and re-pair after flashing.
