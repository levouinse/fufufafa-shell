# Fufufafa Shell - Fork dari Fish Shell

## Tentang Fufufafa Shell

Fufufafa Shell adalah fork dari Fish Shell (https://github.com/fish-shell/fish-shell) yang dikembangkan oleh levouinse.

Repository: https://github.com/levouinse/fufufafa-shell

## Perubahan dari Fish Shell

### 1. Nama dan Branding
- **Nama Project**: fish-shell → fufufafa-shell
- **Nama Binary**: 
  - `fish` → `fufufafa`
  - `fish_indent` → `fufufafa_indent`
  - `fish_key_reader` → `fufufafa_key_reader`
- **Package Name**: fish → fufufafa

### 2. Repository
- **GitHub Organization**: fish-shell → levouinse
- **Repository URL**: https://github.com/fish-shell/fish-shell → https://github.com/levouinse/fufufafa-shell
- **Git Remote**: Telah diupdate ke repository baru

### 3. File yang Direname
- `fish.spec.in` → `fufufafa.spec.in`
- `fish.pc.in` → `fufufafa.pc.in`
- `fish.png` → `fufufafa.png`
- `osx/fish_term_icon.icns` → `osx/fufufafa_term_icon.icns`

### 4. Konfigurasi Build
- **CMake**: Project name diubah dari `fish` ke `fufufafa`
- **Cargo**: Package name dan binary names diupdate
- **macOS Bundle**: Identifier dan display name diupdate
- **RPM/Debian**: Package names dan paths diupdate

### 5. Dokumentasi
- Semua referensi ke fish-shell diupdate ke fufufafa-shell
- URL fishshell.com diganti dengan github.com/levouinse/fufufafa-shell
- README dan dokumentasi lainnya diupdate

### 6. CI/CD
- GitHub Actions workflows diupdate
- Cirrus CI configuration diupdate (repo owner: levouinse)
- Docker images labels diupdate
- BSD build configs diupdate

## Instalasi

### Build dari Source dengan Cargo

```bash
git clone https://github.com/levouinse/fufufafa-shell
cd fufufafa-shell
cargo build --release
```

Binary akan tersedia di `target/release/fufufafa`

### Build dengan CMake

```bash
mkdir build
cd build
cmake ..
cmake --build .
sudo cmake --install .
```

## Kompatibilitas

Fufufafa Shell tetap kompatibel dengan konfigurasi dan script Fish Shell. Namun, nama binary telah berubah dari `fish` menjadi `fufufafa`.

## Lisensi

Fufufafa Shell menggunakan lisensi yang sama dengan Fish Shell:
- GPL-2.0-only AND LGPL-2.0-or-later AND MIT AND PSF-2.0

Lihat file `COPYING` dan `doc_src/license.rst` untuk detail lengkap.

## Kontribusi

Kontribusi sangat diterima! Silakan buka issue atau pull request di:
https://github.com/levouinse/fufufafa-shell

## Kredit

Fufufafa Shell adalah fork dari Fish Shell yang dikembangkan oleh fish-shell contributors.
Original Fish Shell: https://github.com/fish-shell/fish-shell

---

**Catatan**: Ini adalah fork independen dan tidak berafiliasi dengan proyek Fish Shell resmi.
