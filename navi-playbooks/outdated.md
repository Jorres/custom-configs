# Normalize audio
GOOD_SINK=$(pacmd list-sinks | grep -e 'name:' -e 'index:' | grep -B 1 -e 'bluez' | head -n 1 | cut -d: -f2-)
if [ -z "$GOOD_SINK" ]; then
  GOOD_SINK=$(pacmd list-sinks | grep -e 'name:' -e 'index:' | grep -B 1 -e 'analog-stereo' | head -n 1 | cut -d: -f2-)
else
  pacmd set-card-profile $(pacmd list-cards | grep -e 'name:' | grep -e 'bluez' | sed 's/.*<\(.*\)>.*/\1/') a2dp_sink || true
fi
pacmd set-default-sink $GOOD_SINK
GOOD_SOURCE=$(pacmd list-sources | grep -e 'name:' -e 'index:' | grep -B 1 'Yeti' | head -n 1 | cut -d: -f2-)
if [ -z "$GOOD_SOURCE" ]; then
  GOOD_SOURCE=$(pacmd list-sources | grep -e 'name:' -e 'index:' | grep -B 1 'analog-stereo>' | head -n 1 | cut -d: -f2-)
fi
pacmd set-default-source $GOOD_SOURCE

# Toggle Japanese
if gsettings get org.gnome.desktop.input-sources sources | grep -q 'ibus'; then
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
else
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru'), ('ibus', 'mozc-jp')]"
fi

# Normalize English
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"

# Normalize Russian
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'ru')]"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'ru'), ('xkb', 'us')]"

# Change audio sink
pacmd set-default-sink $(pacmd list-sinks | grep -e 'name:' -e 'index:' | fzf | cut -d: -f2-)

# Builtin speakers
pacmd set-default-sink 1
