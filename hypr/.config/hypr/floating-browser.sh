#!/bin/sh
set -eu

existing_windows="$(hyprctl clients -j | jq -r '.[].address')"
uwsm-app -- chromium --new-window &

for _ in $(seq 1 40); do
  window="$({ hyprctl clients -j | jq -r --arg existing "$existing_windows" '
    [.[] | . as $client | select(
      $client.class == "chromium" and ($existing | contains($client.address) | not)
    )][-1].address // empty
  '; } 2>/dev/null)"

  if [ -n "$window" ]; then
    hyprctl dispatch "hl.dsp.window.float({ action = \"enable\", window = \"address:$window\" })" >/dev/null
    hyprctl dispatch "hl.dsp.window.resize({ x = 1400, y = 900, window = \"address:$window\" })" >/dev/null
    hyprctl dispatch "hl.dsp.window.center({ window = \"address:$window\" })" >/dev/null
    exit 0
  fi

  sleep 0.1
done
