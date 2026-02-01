# Panduan Instalasi Fufufafa Shell

## Prasyarat

Pastikan sistem kamu sudah memiliki:
- Rust 1.85 atau lebih baru (`rustc --version`)
- Cargo (`cargo --version`)
- Git
- CMake 3.15+ (opsional, untuk build dengan CMake)
- Python 3.11+ dengan Sphinx (untuk dokumentasi)

### Install Dependencies di Arch Linux

```bash
sudo pacman -S rust cargo git cmake python-sphinx
```

## Cara 1: Build dan Install dengan Cargo (Recommended)

### 1. Clone Repository

```bash
git clone https://github.com/levouinse/fufufafa-shell
cd fufufafa-shell
```

### 2. Build

```bash
cargo build --release
```

Binary akan tersedia di `target/release/`:
- `fufufafa` - Shell utama
- `fufufafa_indent` - Code formatter
- `fufufafa_key_reader` - Key binding reader

### 3. Install ke Sistem

#### Opsi A: Install Manual

```bash
# Copy binaries ke /usr/local/bin
sudo cp target/release/fufufafa /usr/local/bin/
sudo cp target/release/fufufafa_indent /usr/local/bin/
sudo cp target/release/fufufafa_key_reader /usr/local/bin/

# Copy share files (functions, completions, configs)
sudo mkdir -p /usr/local/share/fufufafa
sudo cp -r share/* /usr/local/share/fufufafa/

# Copy man pages (jika ada)
sudo mkdir -p /usr/local/share/man/man1
sudo cp -r target/release/build/*/out/man/man1/*.1 /usr/local/share/man/man1/ 2>/dev/null || true
```

#### Opsi B: Install dengan Cargo

```bash
cargo install --path .
```

Binary akan diinstall ke `~/.cargo/bin/`

### 4. Tambahkan ke /etc/shells

```bash
# Tambahkan fufufafa ke daftar shell yang valid
echo "/usr/local/bin/fufufafa" | sudo tee -a /etc/shells
# atau jika install dengan cargo:
echo "$HOME/.cargo/bin/fufufafa" | sudo tee -a /etc/shells
```

### 5. Set sebagai Default Shell (Opsional)

```bash
# Jika install ke /usr/local/bin
chsh -s /usr/local/bin/fufufafa

# Jika install dengan cargo
chsh -s ~/.cargo/bin/fufufafa
```

## Cara 2: Build dengan CMake

### 1. Clone dan Build

```bash
git clone https://github.com/levouinse/fufufafa-shell
cd fufufafa-shell
mkdir build && cd build
cmake ..
make -j$(nproc)
```

### 2. Install

```bash
sudo make install
```

Default install ke `/usr/local/`. Untuk mengubah prefix:

```bash
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make -j$(nproc)
sudo make install
```

## Verifikasi Instalasi

```bash
# Cek versi
fufufafa --version

# Test shell
fufufafa -c 'echo "Hello from Fufufafa!"'

# Test indent
echo 'function test;echo "hello";end' | fufufafa_indent

# Jalankan shell interaktif
fufufafa
```

## Test Fitur-Fitur

Setelah masuk ke fufufafa shell, test fitur-fitur berikut:

```bash
# Variables
set name "Fufufafa"
echo "Hello, $name!"

# Math
math 10 + 5

# String manipulation
string upper "hello world"
string length "test"

# Loops
for i in 1 2 3
    echo "Number: $i"
end

# Functions
function greet
    echo "Hello from function!"
end
greet

# Conditionals
if test 5 -gt 3
    echo "5 is greater than 3"
end

# Pipes
echo "  test  " | string trim
```

## Konfigurasi

File konfigurasi fufufafa ada di:
- `~/.config/fufufafa/config.fish` - Konfigurasi user
- `/usr/local/share/fufufafa/config.fish` - Konfigurasi global

Buat konfigurasi user:

```bash
mkdir -p ~/.config/fufufafa
touch ~/.config/fufufafa/config.fish
```

Contoh konfigurasi:

```bash
# ~/.config/fufufafa/config.fish

# Set greeting
set fish_greeting "Welcome to Fufufafa Shell!"

# Aliases
alias ll='ls -lah'
alias gs='git status'

# Environment variables
set -x EDITOR vim
set -x PATH $HOME/.local/bin $PATH
```

## Uninstall

### Jika install manual:

```bash
sudo rm /usr/local/bin/fufufafa*
sudo rm -rf /usr/local/share/fufufafa
sudo rm /usr/local/share/man/man1/fufufafa*.1
```

### Jika install dengan cargo:

```bash
cargo uninstall fufufafa
```

### Jika install dengan CMake:

```bash
cd build
sudo make uninstall
```

Jangan lupa hapus dari `/etc/shells`:

```bash
sudo sed -i '/fufufafa/d' /etc/shells
```

## Troubleshooting

### Error: "Could not find sphinx-build"

Install Sphinx:
```bash
sudo pacman -S python-sphinx
```

### Error: "failed to compile"

Pastikan Rust versi 1.85+:
```bash
rustup update
```

### Shell tidak muncul di chsh

Pastikan path sudah ditambahkan ke `/etc/shells`:
```bash
cat /etc/shells | grep fufufafa
```

### Completions tidak bekerja

Copy share files:
```bash
sudo cp -r share/* /usr/local/share/fufufafa/
```

## Fitur yang Sudah Ditest ✅

- ✅ Basic commands (echo, set, math)
- ✅ Variables dan environment
- ✅ String manipulation (upper, lower, trim, length)
- ✅ Loops (for, while)
- ✅ Functions
- ✅ Conditionals (if/else)
- ✅ Pipes dan redirections
- ✅ Code formatting (fufufafa_indent)
- ✅ Key reader (fufufafa_key_reader)

## Support

- Repository: https://github.com/levouinse/fufufafa-shell
- Issues: https://github.com/levouinse/fufufafa-shell/issues

## Lisensi

GPL-2.0-only AND LGPL-2.0-or-later AND MIT AND PSF-2.0

Lihat file `COPYING` untuk detail lengkap.
