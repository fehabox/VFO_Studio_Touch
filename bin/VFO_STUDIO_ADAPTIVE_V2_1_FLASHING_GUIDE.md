# VFO Studio Adaptive V2.1
## Firmware Flashing Guide

### For Waveshare ESP32-S3-Touch-LCD-2 — Standard Version, Without Camera

This guide explains how to install **VFO Studio Adaptive V2.1** on the
tested Waveshare ESP32-S3-Touch-LCD-2 board using the supplied Windows
flashing package.

> **Tested hardware:** Waveshare ESP32-S3-Touch-LCD-2, standard version
> without camera.
>
> **Tested firmware:** `VFO_STUDIO_ADAPTIVE_V2_1.merged.bin`
>
> **Tested flashing method:** `esptool.exe` through the supplied BAT file.
>
> **Validation:** Successfully tested on COM9.

---

# 1. What Is Included?

The `bin` folder contains the files required for flashing:

```text
bin/
│
├── VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
├── esptool.exe
├── FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
├── README_VFO_STUDIO_ADAPTIVE_V2_1.txt
└── VFO_STUDIO_ADAPTIVE_V2_1_DESCRIPTION.txt
```

The important files for flashing are:

### `VFO_STUDIO_ADAPTIVE_V2_1.merged.bin`

This is the complete merged VFO Studio firmware image.

It is intended to be flashed starting at:

```text
0x0
```

A merged binary contains the required firmware sections in one image,
so the user does not need to select separate bootloader, partition-table
and application files.

Espressif documents that a merged binary can subsequently be written to
flash at `0x0` using esptool.  
See the official esptool documentation:
https://docs.espressif.com/projects/esptool/en/latest/esp32s3/esptool/

### `esptool.exe`

This is Espressif's firmware flashing utility.

It communicates with the ESP32-S3 bootloader and writes the firmware to
the board's flash memory.

### `FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat`

This is the recommended way for a normal Windows user to flash VFO Studio.

The BAT file automatically:

1. Checks that `esptool.exe` exists.
2. Checks that the firmware file exists.
3. Erases the existing flash.
4. Writes the merged firmware at `0x0`.
5. Reports whether the operation was successful.

---

# 2. Before You Start

You need:

- Windows PC
- Waveshare ESP32-S3-Touch-LCD-2, standard version without camera
- USB-C data cable
- The VFO Studio V2.1 flashing package
- The board connected directly to the PC

Make sure the USB cable supports **data**, not charging only.

Close Arduino IDE, serial terminals or other programs that may already
be using the ESP32-S3 COM port.

---

# 3. Connect the Board

Connect the Waveshare ESP32-S3-Touch-LCD-2 to the computer using USB-C.

Windows should create a serial/USB port for the board.

The COM number may be different on every computer.

For example:

```text
COM3
COM7
COM9
COM10
```

The VFO Studio V2.1 flashing procedure was tested successfully using:

```text
COM9
```

Your computer may assign another COM number.

---

# 4. Find the COM Port

If you do not know the COM number:

1. Connect the ESP32-S3 board.
2. Open **Windows Device Manager**.
3. Look under **Ports (COM & LPT)**.
4. Identify the port associated with the connected ESP32-S3.
5. Note the COM number.

For example:

```text
USB Serial Device (COM9)
```

---

# 5. Set the COM Port in the BAT File

Open:

```text
FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

with Notepad.

Find:

```bat
set "PORT=COM9"
```

If your board uses another port, change it.

Example:

```bat
set "PORT=COM7"
```

Save the file.

You only need to do this when the COM number differs from the setting
in the BAT file.

---

# 6. Put the Files Together

Keep the following files in the **same folder**:

```text
esptool.exe
VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

Do not rename the firmware file unless you also change the filename in
the BAT file.

A simple folder structure is:

```text
VFO_Studio_V2_1_Flash\
│
├── esptool.exe
├── VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
└── FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

---

# 7. Start Flashing

Double-click:

```text
FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

The program will first display the firmware, COM port and baud rate.

The supplied script uses:

```text
Chip:       ESP32-S3
Port:       COM9   (change if required)
Baud:       921600
Flash addr: 0x0
```

Press a key when the script asks you to continue.

The script will then erase the flash and program the firmware.

---

# 8. What Happens During Flashing?

The process is approximately:

```text
Connect board
      ↓
Select COM port
      ↓
Run BAT file
      ↓
Check esptool.exe
      ↓
Check firmware
      ↓
Erase flash
      ↓
Write VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
      ↓
Verify
      ↓
Flash complete
```

A successful esptool operation reports that the data was written and
verified.

Espressif documents `write-flash`/`write_flash` as the command used to
write binary data to ESP flash, with the flash address supplied together
with the binary filename.  
Official documentation:
https://docs.espressif.com/projects/esptool/en/latest/esp32s3/esptool/

---

# 9. Boot / Download Mode

Normally the board should enter download mode automatically.

If esptool cannot connect to the ESP32-S3, manually place the board in
download/boot mode according to the board's controls:

1. Hold **BOOT**.
2. Press and release **RESET/EN**.
3. Release **BOOT**.
4. Run the BAT file again.

If Windows creates a new COM port after entering download mode, check
Device Manager again and update the `PORT=` value in the BAT file.

---

# 10. Important: Flash Erase

The supplied BAT file performs a full flash erase before writing the
VFO Studio firmware.

This is intentional.

It gives the firmware a clean installation and avoids old flash contents
interfering with the new firmware.

**Important:** Any user data stored in flash that is not recreated by the
new firmware can be lost.

Make sure you are comfortable with this before starting the flash
operation.

---

# 11. If Flashing Fails

If the BAT file reports an error, check the following.

### Check the USB cable

Use a USB-C cable that supports data.

### Check the COM port

Make sure the port in the BAT file matches the board.

Example:

```bat
set "PORT=COM9"
```

### Close other serial programs

Arduino IDE, serial terminals and other applications can keep the COM
port busy.

### Try download mode

Use:

```text
BOOT + RESET/EN
```

as described above.

### Check the files

The BAT file and firmware must be in the same directory as `esptool.exe`.

Required:

```text
esptool.exe
VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

### Try another USB port

If the board is not detected, try another USB port on the computer.

---

# 12. After a Successful Flash

When the BAT file reports:

```text
FLASH COMPLETE
```

the firmware has been written successfully.

Disconnect and reconnect USB if necessary.

The VFO Studio Adaptive V2.1 interface should start on the Waveshare
ESP32-S3-Touch-LCD-2 display.

You can then begin normal Touch operation.

---

# 13. First Operation

After flashing:

1. Wait for the VFO Studio main screen.
2. Touch the left side of the dial to tune DOWN.
3. Touch the right side of the dial to tune UP.
4. Use a short touch for one step.
5. Hold the dial for continuous tuning.
6. Use the menu icon to open the main menu.
7. Use **Design** to select/configure the interface.
8. Use **Doors** for quick-access functions.

For complete operation instructions, see:

**VFO Studio Touch V2.1 Personal — User Guide**

---

# 14. Free vs Personal Pro

The firmware edition determines which functions are available.

## Free Edition

- Touch VFO operation
- 2 design slots
- No USB Serial communication
- No scanner
- Free to distribute
- Not for resale

## Personal Pro

- Touch VFO operation
- 10 design slots
- USB Serial communication
- Scanner
- Future upgrade path for Bluetooth, Wi-Fi/TCP and other communication
  functions

---

# 15. Tested Hardware

VFO Studio Adaptive V2.1 has been tested and verified on:

**Waveshare ESP32-S3-Touch-LCD-2**

**Standard version — without camera**

Official board:

https://www.waveshare.com/esp32-s3-touch-lcd-2.htm

The tested configuration includes the integrated touch display.

> This V2.1 release has been validated on the specific Waveshare
> ESP32-S3-Touch-LCD-2 standard board. Other ESP32-S3 boards, display
> variants or camera versions are not covered by this validation.

---

# 16. Tested Flash Configuration

```text
Firmware:
VFO_STUDIO_ADAPTIVE_V2_1.merged.bin

Target:
ESP32-S3

Board:
Waveshare ESP32-S3-Touch-LCD-2
Standard version / no camera

Flash address:
0x0

Baud:
921600

Test COM port:
COM9

Tool:
esptool.exe

Status:
TESTED AND WORKING
```

---

# 17. Why a Merged Binary?

VFO Studio is distributed as a complete merged firmware image so the
user does not need to understand the individual ESP32-S3 firmware
components.

Instead of manually selecting several files and addresses, the user
flashes:

```text
VFO_STUDIO_ADAPTIVE_V2_1.merged.bin
```

at:

```text
0x0
```

This is also why the supplied BAT file can perform the complete
installation with one command.

Espressif documents the use of merged binaries for transferring and
flashing a complete firmware image later without requiring the original
build environment.  
Official documentation:
https://docs.espressif.com/projects/esptool/en/latest/esp32s3/esptool/

---

# 18. Web Flashing

A browser-based flashing method was also investigated using Espressif's
web tooling.

For this V2.1 release, the **tested and recommended method is the
supplied Windows BAT + esptool package**.

The web flashing method has not been validated for this specific VFO
Studio board/firmware combination.

Therefore, users should use:

```text
FLASH_VFO_STUDIO_ADAPTIVE_V2_1.bat
```

for the V2.1 release.

---

# 19. Support Information

When reporting a flashing problem, include:

- Windows version
- COM port number
- Exact error message from the BAT window
- Whether the board appears in Device Manager
- Whether BOOT/RESET download mode was required
- Confirmation that the board is the standard
  Waveshare ESP32-S3-Touch-LCD-2 without camera

Do not report a different ESP32-S3 board as a V2.1-tested configuration.

---

# VFO Studio Adaptive V2.1

**@fehabox**

> **Don't change the radio. Change the design.**
