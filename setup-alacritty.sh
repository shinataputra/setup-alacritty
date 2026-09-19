```bash
#!/usr/bin/env bash

# ==========================================================
# PERSONAL ALACRITTY SETUP
# CachyOS / Arch Linux
# ==========================================================

set -e

# ----------------------------------------------------------
# COLORS
# ----------------------------------------------------------

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

echo
echo -e "${CYAN}==========================================${RESET}"
echo -e "${CYAN}       PERSONAL ALACRITTY SETUP${RESET}"
echo -e "${CYAN}==========================================${RESET}"
echo

# ----------------------------------------------------------
# CHECK PACMAN
# ----------------------------------------------------------

if ! command -v pacman >/dev/null 2>&1; then
    echo "Error: pacman tidak ditemukan."
    echo "Script ini dibuat untuk CachyOS / Arch Linux."
    exit 1
fi

# ----------------------------------------------------------
# INSTALL PACKAGES
# ----------------------------------------------------------

echo -e "${YELLOW}[1/5] Installing packages...${RESET}"

sudo pacman -S --needed \
    alacritty \
    fish \
    starship \
    ttf-jetbrains-mono-nerd

echo -e "${GREEN}Packages OK.${RESET}"
echo

# ----------------------------------------------------------
# DIRECTORIES
# ----------------------------------------------------------

echo -e "${YELLOW}[2/5] Creating configuration directories...${RESET}"

mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fish
mkdir -p ~/.config

echo -e "${GREEN}Directories OK.${RESET}"
echo

# ----------------------------------------------------------
# ALACRITTY CONFIG
# ----------------------------------------------------------

echo -e "${YELLOW}[3/5] Creating Alacritty configuration...${RESET}"

cat > ~/.config/alacritty/alacritty.toml <<'EOF'
# ==========================================================
# PERSONAL ALACRITTY CONFIG
# Nord / Cyan
# ==========================================================

[window]
opacity = 0.92
decorations = "Full"
dynamic_title = true

[window.padding]
x = 14
y = 12

[scrolling]
history = 10000
multiplier = 3

# ----------------------------------------------------------
# FONT
# ----------------------------------------------------------

[font]
size = 12.5

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Regular"

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Bold"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Italic"

# ----------------------------------------------------------
# COLORS
# ----------------------------------------------------------

[colors.primary]
background = "0x2E3440"
foreground = "0xECEFF4"

[colors.cursor]
text = "0x2E3440"
cursor = "0x8FBCBB"

[colors.selection]
text = "0x2E3440"
background = "0x88C0D0"

[colors.normal]
black = "0x3B4252"
red = "0xBF616A"
green = "0xA3BE8C"
yellow = "0xEBCB8B"
blue = "0x81A1C1"
magenta = "0xB48EAD"
cyan = "0x8FBCBB"
white = "0xECEFF4"

[colors.bright]
black = "0x4C566A"
red = "0xBF616A"
green = "0xA3BE8C"
yellow = "0xEBCB8B"
blue = "0x81A1C1"
magenta = "0xB48EAD"
cyan = "0x8FBCBB"
white = "0xFFFFFF"

# ----------------------------------------------------------
# SELECTION
# ----------------------------------------------------------

[selection]
semantic_escape_chars = ",│`|:\"' ()[]{}<>	"
save_to_clipboard = true

# ----------------------------------------------------------
# CURSOR
# ----------------------------------------------------------

[cursor]
style = { shape = "Underline", blinking = "Off" }
unfocused_hollow = true
thickness = 0.15

# ----------------------------------------------------------
# MOUSE
# ----------------------------------------------------------

[mouse]
hide_when_typing = true

[[mouse.bindings]]
mouse = "Middle"
mods = "None"
action = "PasteSelection"

# ----------------------------------------------------------
# KEYBOARD
# ----------------------------------------------------------

[[keyboard.bindings]]
key = "Paste"
mods = "None"
action = "Paste"

[[keyboard.bindings]]
key = "Copy"
mods = "None"
action = "Copy"

[[keyboard.bindings]]
key = "L"
mods = "Control"
action = "ClearLogNotice"

[[keyboard.bindings]]
key = "L"
mods = "Control"
mode = "~Vi"
chars = "\f"

[[keyboard.bindings]]JetBrainsMono Nerd Font
key = "PageUp"
mods = "Shift"
mode = "~Alt"
action = "ScrollPageUp"

[[keyboard.bindings]]
key = "PageDown"
mods = "Shift"
mode = "~Alt"
action = "ScrollPageDown"

[[keyboard.bindings]]
key = "Home"
mods = "Shift"
mode = "~Alt"
action = "ScrollToTop"

[[keyboard.bindings]]
key = "End"
mods = "Shift"
mode = "~Alt"
action = "ScrollToBottom"

[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

[[keyboard.bindings]]
key = "F"
mods = "Control|Shift"
action = "SearchForward"

[[keyboard.bindings]]
key = "B"
mods = "Control|Shift"
action = "SearchBackward"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
mode = "Vi"
action = "ClearSelection"

[[keyboard.bindings]]
key = "Key0"
mods = "Control"
action = "ResetFontSize"
EOF

echo -e "${GREEN}Alacritty config OK.${RESET}"
echo

# ----------------------------------------------------------
# FISH CONFIG
# ----------------------------------------------------------

echo -e "${YELLOW}[4/5] Configuring Fish...${RESET}"

FISH_CONFIG="$HOME/.config/fish/config.fish"

touch "$FISH_CONFIG"

if ! grep -q "starship init fish" "$FISH_CONFIG"; then
    cat >> "$FISH_CONFIG" <<'EOF'

# Personal Alacritty / Fish setup
starship init fish | source
EOF
fi

echo -e "${GREEN}Fish OK.${RESET}"
echo

# ----------------------------------------------------------
# STARSHIP CONFIG
# ----------------------------------------------------------

echo -e "${YELLOW}[5/5] Creating Starship configuration...${RESET}"

cat > ~/.config/starship.toml <<'EOF'
# ==========================================================
# PERSONAL STARSHIP CONFIG
# ==========================================================

format = """
$username$hostname$directory$git_branch$git_status
$character"""

[username]
show_always = true
style_user = "bold cyan"
format = "[$user]($style) "

[hostname]
ssh_only = false
style = "bold purple"
format = "on [$hostname]($style) "

[directory]
style = "bold blue"
truncation_length = 3
format = "[$path]($style) "

[git_branch]
symbol = " "
style = "bold green"

[git_status]
style = "bold yellow"

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
EOF

echo -e "${GREEN}Starship OK.${RESET}"
echo

# ----------------------------------------------------------
# FONT CACHE
# ----------------------------------------------------------

fc-cache -f >/dev/null 2>&1 || true

# ----------------------------------------------------------
# FINISH
# ----------------------------------------------------------

echo -e "${GREEN}==========================================${RESET}"
echo -e "${GREEN}       SETUP SELESAI${RESET}"
echo -e "${GREEN}==========================================${RESET}"
echo

echo "Alacritty : $(command -v alacritty)"
echo "Fish      : $(command -v fish)"
echo "Starship  : $(command -v starship)"
echo "Font      : JetBrainsMono Nerd Font"
echo

echo "Jalankan:"
echo
echo "    alacritty"
echo
echo "atau:"
echo
echo "    source ~/.config/fish/config.fish"
echo

echo -e "${CYAN}Personal Alacritty siap.${RESET}"
```
