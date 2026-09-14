# glorfindel — host-specific customizations

**Tracked configs:** `hypr/host.lua`, `omarchy/shell.json`, `chromium-flags.conf`.

## Kernel cmdline customizations (NOT in this repo — live in /boot/limine.conf)

These live outside the stow tree (on the ESP, root-owned). Verify after every
kernel/limine/bootloader update, else they silently revert.

### button.lid_init_state=open (2026-09-14)

ASUS ROG Zephyrus G14 GA403UM ships a broken ACPI lid device: kernel logs
`ACPI: button: The lid device is not compliant to SW_LID.` Lid-close never
reaches systemd-logind, so the laptop does **not** suspend when closed — it
keeps running in a backpack at full power.

Fix: append `button.lid_init_state=open` to the `cmdline:` line in
`/boot/limine.conf`, then run `sudo limine-install`.

Current full cmdline reference:
`cryptdevice=PARTUUID=1e0ae53b-0e78-405d-b96e-bbe245f06e5b:root root=/dev/mapper/root zswap.enabled=0 rootflags=subvol=@ rw rootfstype=btrfs rtc_cmos.use_acpi_alarm=1 resume=/dev/mapper/root resume_offset=1934957 initramfs_async=0 quiet splash loglevel=0 systemd.show_status=false rd.udev.log_level=0 vt.global_cursor_default=0 button.lid_init_state=open`

**Verify it's active:** `grep button /proc/cmdline` → must print
`button.lid_init_state=open`.

**Verify lid handling works:** close the lid → `journalctl -u systemd-logind`
should show `Lid closed.` + `Suspending...`.

### Check list after a system update

1. `grep button /proc/cmdline` — lid_init_state must be present.
2. `cat /proc/acpi/button/lid/LID0/state` — must report actual position.
3. Close lid, confirm `journalctl -u systemd-logind` shows suspend.
4. If any of the above fails, re-append the param and `sudo limine-install`.