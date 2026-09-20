# Personal Alacritty Setup

Personal setup script untuk menyiapkan terminal di **CachyOS / Arch Linux** dengan:

* Alacritty
* Fish Shell
* Starship
* JetBrainsMono Nerd Font
* Nord color scheme
* Transparency
* Git status pada prompt
* Custom keyboard shortcuts

## Tampilan

Prompt yang digunakan:

```text
~/workspace/setup-alacritty 󰊢 main !
❯
```

Sederhana, bersih, dan tetap menampilkan informasi Git.

## Instalasi

Clone repository:

```bash
git clone https://github.com/shinataputra/setup-alacritty.git
cd setup-alacritty
```

Beri permission executable:

```bash
chmod +x setup-alacritty.sh
```

Cek syntax script:

```bash
bash -n setup-alacritty.sh
```

Jalankan:

```bash
./setup-alacritty.sh
```

## Yang Diinstall

Script akan menginstall package berikut menggunakan `pacman`:

```text
alacritty
fish
starship
ttf-jetbrains-mono-nerd
```

## Konfigurasi

Script membuat atau memperbarui:

```text
~/.config/alacritty/alacritty.toml
~/.config/fish/config.fish
~/.config/starship.toml
```

### Alacritty

Konfigurasi mencakup:

* JetBrainsMono Nerd Font
* Font size 12.5
* Transparency 0.92
* Nord color scheme
* Cursor underline
* Clipboard
* Mouse paste
* Custom keyboard shortcuts

### Fish

Fish digunakan sebagai shell utama untuk konfigurasi personal terminal.

Starship diaktifkan melalui:

```fish
if status is-interactive
    starship init fish | source
end
```

### Starship

Prompt menampilkan:

* Current directory
* Git branch
* Git status
* Status command melalui symbol `❯`

Contoh:

```text
~/workspace/setup-alacritty 󰊢 main !
❯
```

## Setelah Setup

Reload konfigurasi Fish:

```bash
source ~/.config/fish/config.fish
```

Atau tutup dan buka kembali terminal.

Untuk menjalankan Alacritty:

```bash
alacritty
```

Untuk membuka window Alacritty baru dari terminal:

```bash
alacritty &
```

## Update Setup

Jika konfigurasi personal berubah, edit:

```bash
nano setup-alacritty.sh
```

Setelah melakukan perubahan, cek:

```bash
bash -n setup-alacritty.sh
```

Lihat perubahan Git:

```bash
git diff
```

Jika sudah sesuai:

```bash
git add setup-alacritty.sh
git commit -m "update personal terminal setup"
git push
```

## Tujuan

Repository ini dibuat sebagai **personal setup script** agar konfigurasi terminal dapat digunakan kembali setelah melakukan reinstall CachyOS atau Arch Linux.

Daripada konfigurasi ulang satu per satu, cukup:

```bash
git clone https://github.com/shinataputra/setup-alacritty.git
cd setup-alacritty
./setup-alacritty.sh
```

---

**Personal setup by Shinataputra**
