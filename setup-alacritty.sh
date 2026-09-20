#!/usr/bin/env bash

set -e

# ==========================================================
# PERSONAL ALACRITTY SETUP
# CachyOS / Arch Linux
# ==========================================================

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
# CHECK SYSTEM
# ----------------------------------------------------------

if ! command -v pacman >/dev/null 2>&1; then
    echo -e "${YELLOW}Script ini dibuat untuk CachyOS / Arch Linux.${RESET}"
    exit 1
fi

# ----------------------------------------------------------
# INSTALL PACKAGES
# ----------------------------------------------------------

echo -e "${YELLOW}[1/5] Installing packages...${RESET}"

sudo pacman -S --needed --noconfirm \
    alacritty \
    fish \
    starship \
    ttf-jetbrains-mono-nerd

echo -e "${GREEN}Packages OK.${RESET}"
echo

# ----------------------------------------------------------
# CREATE DIRECTORIES
# ----------------------------------------------------------

echo -e "${YELLOW}[2/5] Creating configuration directories...${RESET}"

mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/fish"

echo -e "${GREEN}Directories OK.${RESET}"
echo

# ----------------------------------------------------------
# ALACRITTY CONFIG
# ----------------------------------------------------------

echo -e "${YELLOW}[3/5] Creating Alacritty configuration...${RESET}"

cat > "$HOME/.config/alacritty/alacritty.toml" <<'EOF'
# ==========================================================
# PERSONAL ALACRITTY CONFIG
# ==========================================================

[window]
opacity = 0.92

[window.padding]
x = 14
y = 12

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

[colors.primary]
background = "#2E3440"
foreground = "#D8DEE9"

[colors.normal]
black = "#3B4252"
red = "#BF616A"
green = "#A3BE8C"
yellow = "#EBCB8B"
blue = "#81A1C1"
magenta = "#B48EAD"
cyan = "#88C0D0"
white = "#E5E9F0"

[colors.bright]
black = "#4C566A"
red = "#BF616A"
green = "#A3BE8C"
yellow = "#EBCB8B"
blue = "#81A1C1"
magenta = "#B48EAD"
cyan = "#8FBCBB"
white = "#ECEFF4"

[selection]
semantic_escape_chars = ",│`|:\"' ()[]{}<>"
save_to_clipboard = true

[cursor]
style = { shape = "Underline", blinking = "Never" }
unfocused_hollow = true
thickness = 0.15

[mouse]
hide_when_typing = true

[[mouse.bindings]]
mouse = "Middle"
action = "PasteSelection"

[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

[[keyboard.bindings]]
key = "PageUp"
mods = "Shift"
action = "ScrollPageUp"

[[keyboard.bindings]]
key = "PageDown"
mods = "Shift"
action = "ScrollPageDown"

[[keyboard.bindings]]
key = "Home"
mods = "Control|Shift"
action = "ScrollToTop"

[[keyboard.bindings]]
key = "End"
mods = "Control|Shift"
action = "ScrollToBottom"

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

if ! grep -q "PERSONAL ALACRITTY SETUP" "$FISH_CONFIG"; then
    cat >> "$FISH_CONFIG" <<'EOF'

# ==========================================================
# PERSONAL ALACRITTY SETUP
# ==========================================================

if status is-interactive
    starship init fish | source
end
EOF
fi

echo -e "${GREEN}Fish OK.${RESET}"
echo

# ----------------------------------------------------------
# STARSHIP CONFIG
# ----------------------------------------------------------

echo -e "${YELLOW}[5/5] Creating Starship configuration...${RESET}"

cat > "$HOME/.config/starship.toml" <<'EOF'
# ==========================================================
# PERSONAL STARSHIP CONFIG
# ==========================================================
format = """
$directory $git_branch$git_status
$character"""

[directory]
style = "bold blue"
format = "[$path]($style)"

[git_branch]
symbol = "󰊢 "
style = "bold green"
format = "[$symbol$branch]($style)"

[git_status]
style = "bold red"
format = " [$all_status$ahead_behind]($style)"

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
EOF

echo -e "${GREEN}Starship OK.${RESET}"
echo

# ----------------------------------------------------------
# FONT CACHE
# ----------------------------------------------------------

echo -e "${YELLOW}Refreshing font cache...${RESET}"

fc-cache -f >/dev/null 2>&1 || true

echo -e "${GREEN}Font cache OK.${RESET}"
echo

# ----------------------------------------------------------
# FINISH
# ----------------------------------------------------------

echo
echo -e "${GREEN}==========================================${RESET}"
echo -e "${GREEN}       SETUP SELESAI ✓${RESET}"
echo -e "${GREEN}==========================================${RESET}"
echo

echo -e "${GREEN}✓ Alacritty${RESET} : $(command -v alacritty)"
echo -e "${GREEN}✓ Fish${RESET}      : $(command -v fish)"
echo -e "${GREEN}✓ Starship${RESET}  : $(command -v starship)"
echo -e "${GREEN}✓ Font${RESET}      : JetBrainsMono Nerd Font"
echo

echo -e "${CYAN}Konfigurasi:${RESET}"
echo "  Alacritty : ~/.config/alacritty/alacritty.toml"
echo "  Fish      : ~/.config/fish/config.fish"
echo "  Starship  : ~/.config/starship.toml"
echo

echo -e "${CYAN}Versi:${RESET}"
echo "  Alacritty : $(alacritty --version)"
echo "  Fish      : $(fish --version)"
echo "  Starship  : $(starship --version)"
echo

echo -e "${CYAN}Setup yang diterapkan:${RESET}"
echo "  • JetBrainsMono Nerd Font"
echo "  • Nord color scheme"
echo "  • Alacritty transparency"
echo "  • Fish shell"
echo "  • Starship prompt"
echo "  • Git status"
echo "  • Custom keyboard shortcuts"
echo

echo -e "${YELLOW}Langkah berikutnya:${RESET}"
echo
echo "  1. Tutup Alacritty yang sedang terbuka."
echo "  2. Buka Alacritty kembali."
echo "  3. Jika Fish belum menggunakan konfigurasi baru:"
echo
echo "       source ~/.config/fish/config.fish"
echo

echo -e "${GREEN}Personal Alacritty setup berhasil diterapkan!${RESET}"
echo
