# Package tracking

Passive snapshots of what's explicitly installed on each machine, for backup
and cross-machine visibility. **Nothing here installs, removes, or updates
anything automatically** - reconciling differences between machines is
always a deliberate, manual decision.

## What's tracked

- `<hostname>/pacman-native.txt` - explicitly-installed official-repo
  packages (`pacman -Qqen`): things you asked for, not pulled in as a
  dependency.
- `<hostname>/pacman-aur.txt` - explicitly-installed AUR/foreign packages
  (`pacman -Qqem`), installed via `yay` or manual `makepkg`.

Global dev-tool versions (`mise`) are tracked separately, as a normal shared
dotfile: `mise/.config/mise/config.toml`. Unlike pacman packages, mise's tool
list is small and not machine-specific, so it's just one shared file.

## Regenerating a snapshot

Run on the machine itself, whenever you want to record a change:

```
~/.dotfiles/packages/update.sh
```

Then review and commit like anything else:

```
git -C ~/.dotfiles diff -- packages/$(hostname)
git -C ~/.dotfiles add packages/$(hostname) && git -C ~/.dotfiles commit -m "Update $(hostname) package snapshot"
```

## Comparing machines

```
diff packages/glorfindel/pacman-native.txt packages/tensorcruncher/pacman-native.txt
```

Lines starting `<` are glorfindel-only, `>` are tensorcruncher-only. Useful
before deciding "should this be installed everywhere" vs. "this is
legitimately host-specific" (e.g. `asusctl`/`steam` only make sense on the
laptop; `virtualbox`/`spotify` only on the desktop).

## Restoring / provisioning a machine

```
sudo pacman -S --needed - < packages/<hostname>/pacman-native.txt
yay -S --needed - < packages/<hostname>/pacman-aur.txt
mise install   # from ~/.dotfiles/mise/.config/mise/config.toml
```
