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

## modprobe.d customizations (NOT in this repo — live in /etc/modprobe.d/, root-owned)

### zz-nvidia-power.conf: NVIDIA S0ix suspend/resume fix (2026-09-23)

Same root-cause family as the lid fix above: this GA403UM's NVIDIA GPU was
failing to suspend cleanly (dmesg: `nv_pmops_freeze` returning `-5`,
`pci_pm_freeze()` failing). Fixed with:

    options nvidia NVreg_EnableS0ixPowerManagement=1 NVreg_PreserveVideoMemoryAllocations=0

in `/etc/modprobe.d/zz-nvidia-power.conf` (the `zz-` prefix sorts it after
the packaged `nvidia.conf`, since modprobe options accumulate/override in
file-name order). Went through a couple of filenames while landing on this
(`30-nvidia-s0ix.conf`, `99-nvidia-power.conf`) — only `zz-nvidia-power.conf`
is current; the others were removed.

Not owned by any package. Omarchy's own `nvidia.sh` installer only ever
writes `/etc/modprobe.d/nvidia.conf` (just `nvidia_drm modeset=1`) — a plain
`omarchy update` doesn't touch this file, so it's safe across updates. Still
worth checking after an NVIDIA driver upgrade or a fresh install, since
(like the lid fix) it's invisible to git either way.

modprobe.d options only apply the next time the `nvidia` module loads (the
core module unloads itself when the dGPU is runtime-suspended on this
hybrid laptop, so it may not be loaded right now — a reboot guarantees a
fresh load either way).

**Verify it's active (after a reboot or a fresh module load):**
`cat /sys/module/nvidia/parameters/EnableS0ixPowerManagement` — module not
loaded means that path won't exist yet; that's expected until something
touches the dGPU.
**Verify suspend/resume is clean:** suspend then resume, then
`journalctl -b | grep -iE "pci_pm_freeze|nv_pmops_freeze"` should show no new
freeze errors.