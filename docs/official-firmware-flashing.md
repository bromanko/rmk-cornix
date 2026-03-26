# Official Cornix firmware flashing notes

These are the steps used to confirm and flash the latest official firmware on a Jezail Cornix.

## What we verified

- The keyboard shows up in **Vial** as **Cornix**.
- The official firmware appears to be **RMK + Vial** based.
- The latest official firmware found was **V1.12** from:
  - `https://github.com/Jezailfunder-LooozQ/Cornix`

## Firmware files used

Downloaded to:

- `downloads/cornix-firmware/V1.12.zip`
- `downloads/cornix-firmware/cornix-left.uf2`
- `downloads/cornix-firmware/cornix-right.uf2`

## Notes about the halves

- The **left half** is the main USB/Vial side.
- The **right half** does **not** normally appear as a Vial device.
- The right USB port is used for **charging** and **firmware flashing**.

## How we flashed the firmware

### Left half

Option 1:
1. Plug in the **left half** by USB.
2. Open **Vial**.
3. Go to **Security**.
4. Click **Reboot to bootloader**.
5. When the **Cornix** USB drive appears, copy:
   - `downloads/cornix-firmware/cornix-left.uf2`
6. Wait for the drive to auto-eject.

Option 2:
1. Plug in the **left half** by USB.
2. Find the tiny **reset button** above the innermost thumb key.
3. Double-click it quickly.
4. When the **Cornix** USB drive appears, copy:
   - `downloads/cornix-firmware/cornix-left.uf2`
5. Wait for the drive to auto-eject.

### Right half

1. Plug in the **right half** by USB.
2. Find the tiny **reset button** above the innermost thumb key.
3. Double-click it quickly.
4. When the **Cornix** USB drive appears, copy:
   - `downloads/cornix-firmware/cornix-right.uf2`
5. Wait for the drive to auto-eject.

## Important reminders

- Flash **left** with `cornix-left.uf2`.
- Flash **right** with `cornix-right.uf2`.
- The right half not showing up in Vial is expected.
- Firmware updates may require Bluetooth re-pairing afterward.

## Result

Both halves were flashed successfully to the latest official firmware found: **V1.12**.
