# Panduan Instalasi Fufufafa Shell - SIMPLE

## 🚀 Quick Install (Sudah Terinstall di Sistem Ini)

Fufufafa shell sudah terinstall di sistem ini:

```bash
# Cek versi
fufufafa --version

# Jalankan shell
fufufafa

# Test command
fufufafa -c 'echo "Hello from Fufufafa!"'
```

## 📍 Lokasi File

```
/usr/local/bin/fufufafa              # Binary utama
/usr/local/bin/fufufafa_indent       # Code formatter
/usr/local/bin/fufufafa_key_reader   # Key reader
/usr/local/share/fufufafa/           # Config, functions, completions
```

## ✨ Set sebagai Default Shell

```bash
# Lihat shell yang tersedia
cat /etc/shells

# Set fufufafa sebagai default
chsh -s /usr/local/bin/fufufafa

# Logout dan login lagi untuk apply
```

## 🧪 Test Fitur

```bash
# Jalankan fufufafa
fufufafa

# Di dalam fufufafa shell, test:
set name "Test"
echo "Hello, $name!"

math 10 + 5

string upper "hello world"

for i in 1 2 3
    echo "Number: $i"
end

# Keluar
exit
```

## 📦 Install di Komputer Lain

### Cara 1: Clone dan Build

```bash
git clone https://github.com/levouinse/fufufafa-shell
cd fufufafa-shell

# Build
cargo build --release

# Install
sudo cp target/release/fufufafa* /usr/local/bin/
sudo mkdir -p /usr/local/share/fufufafa
sudo cp -r share/* /usr/local/share/fufufafa/
echo "/usr/local/bin/fufufafa" | sudo tee -a /etc/shells
```

### Cara 2: Gunakan Script Install

```bash
git clone https://github.com/levouinse/fufufafa-shell
cd fufufafa-shell
cargo build --release
sudo cp target/release/fufufafa* /usr/local/bin/
sudo mkdir -p /usr/local/share/fufufafa
sudo cp -r share/* /usr/local/share/fufufafa/
echo "/usr/local/bin/fufufafa" | sudo tee -a /etc/shells
```

## 🗑️ Uninstall

```bash
# Hapus binaries
sudo rm /usr/local/bin/fufufafa*

# Hapus share files
sudo rm -rf /usr/local/share/fufufafa

# Hapus dari /etc/shells
sudo sed -i '/fufufafa/d' /etc/shells

# Jika fufufafa adalah default shell, ganti dulu:
chsh -s /bin/bash
```

## 🔧 Konfigurasi

Buat file config di `~/.config/fufufafa/config.fish`:

```bash
mkdir -p ~/.config/fufufafa
nano ~/.config/fufufafa/config.fish
```

Contoh config:

```fish
# Greeting
set fish_greeting "Welcome to Fufufafa Shell!"

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias gp='git push'

# Environment
set -x EDITOR vim
set -x PATH $HOME/.local/bin $PATH

# Colors
set fish_color_command blue
set fish_color_error red
```

## 📚 Dokumentasi

- Repository: https://github.com/levouinse/fufufafa-shell
- Based on: Fish Shell (https://fishshell.com)
- Lihat `INSTALLATION.md` untuk panduan lengkap
- Lihat `FUFUFAFA_CHANGES.md` untuk daftar perubahan

## ✅ Status Instalasi Sistem Ini

```
✓ Binaries: /usr/local/bin/fufufafa*
✓ Share files: /usr/local/share/fufufafa/
✓ Added to: /etc/shells
✓ Version: 4.3.3-185-g44920b4be-dirty
✓ Status: READY TO USE
```

## 🎯 Next Steps

1. Test: `fufufafa -c 'echo "Test OK"'`
2. Run: `fufufafa`
3. Set default: `chsh -s /usr/local/bin/fufufafa`
4. Enjoy! 🎉
