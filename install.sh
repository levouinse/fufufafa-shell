#!/bin/bash
# Fufufafa Shell Installation Script
# Usage: ./install.sh [--prefix=/usr/local]

set -e

PREFIX="${1:-/usr/local}"
PREFIX="${PREFIX#--prefix=}"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         Fufufafa Shell Installation Script                  ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Installing to: $PREFIX"
echo ""

# Check if running as root for system-wide install
if [[ "$PREFIX" == "/usr"* ]] && [[ $EUID -ne 0 ]]; then
   echo "Error: System-wide installation requires root privileges."
   echo "Please run: sudo ./install.sh"
   exit 1
fi

# Build
echo "→ Building fufufafa shell..."
cargo build --release

if [ $? -ne 0 ]; then
    echo "✗ Build failed!"
    exit 1
fi

echo "✓ Build successful!"
echo ""

# Install binaries
echo "→ Installing binaries to $PREFIX/bin..."
mkdir -p "$PREFIX/bin"
cp target/release/fufufafa "$PREFIX/bin/"
cp target/release/fufufafa_indent "$PREFIX/bin/"
cp target/release/fufufafa_key_reader "$PREFIX/bin/"
chmod +x "$PREFIX/bin/fufufafa"*

echo "✓ Binaries installed!"
echo ""

# Install share files
echo "→ Installing share files to $PREFIX/share/fufufafa..."
mkdir -p "$PREFIX/share/fufufafa"
cp -r share/* "$PREFIX/share/fufufafa/"

echo "✓ Share files installed!"
echo ""

# Install man pages if available
if ls target/release/build/*/out/man/man1/*.1 1> /dev/null 2>&1; then
    echo "→ Installing man pages to $PREFIX/share/man/man1..."
    mkdir -p "$PREFIX/share/man/man1"
    cp target/release/build/*/out/man/man1/*.1 "$PREFIX/share/man/man1/" 2>/dev/null || true
    echo "✓ Man pages installed!"
else
    echo "⚠ Man pages not found (sphinx not installed?)"
fi
echo ""

# Add to /etc/shells
SHELL_PATH="$PREFIX/bin/fufufafa"
if ! grep -q "$SHELL_PATH" /etc/shells 2>/dev/null; then
    echo "→ Adding fufufafa to /etc/shells..."
    if [[ $EUID -eq 0 ]]; then
        echo "$SHELL_PATH" >> /etc/shells
        echo "✓ Added to /etc/shells!"
    else
        echo "⚠ Cannot modify /etc/shells (not root)"
        echo "  Run manually: echo '$SHELL_PATH' | sudo tee -a /etc/shells"
    fi
else
    echo "✓ Already in /etc/shells"
fi
echo ""

# Summary
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              Installation Complete! ✓                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Installed files:"
echo "  • $PREFIX/bin/fufufafa"
echo "  • $PREFIX/bin/fufufafa_indent"
echo "  • $PREFIX/bin/fufufafa_key_reader"
echo "  • $PREFIX/share/fufufafa/"
echo ""
echo "Test installation:"
echo "  $PREFIX/bin/fufufafa --version"
echo ""
echo "Set as default shell:"
echo "  chsh -s $PREFIX/bin/fufufafa"
echo ""
echo "Start fufufafa:"
echo "  $PREFIX/bin/fufufafa"
echo ""
