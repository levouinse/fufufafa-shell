#!/bin/bash
# Fufufafa Shell Uninstallation Script
# Usage: ./uninstall.sh [--prefix=/usr/local]

set -e

PREFIX="${1:-/usr/local}"
PREFIX="${PREFIX#--prefix=}"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║       Fufufafa Shell Uninstallation Script                  ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Uninstalling from: $PREFIX"
echo ""

# Check if running as root for system-wide uninstall
if [[ "$PREFIX" == "/usr"* ]] && [[ $EUID -ne 0 ]]; then
   echo "Error: System-wide uninstallation requires root privileges."
   echo "Please run: sudo ./uninstall.sh"
   exit 1
fi

# Remove binaries
echo "→ Removing binaries from $PREFIX/bin..."
rm -f "$PREFIX/bin/fufufafa"
rm -f "$PREFIX/bin/fufufafa_indent"
rm -f "$PREFIX/bin/fufufafa_key_reader"
echo "✓ Binaries removed!"
echo ""

# Remove share files
echo "→ Removing share files from $PREFIX/share/fufufafa..."
rm -rf "$PREFIX/share/fufufafa"
echo "✓ Share files removed!"
echo ""

# Remove man pages
echo "→ Removing man pages from $PREFIX/share/man/man1..."
rm -f "$PREFIX/share/man/man1/fufufafa"*.1
echo "✓ Man pages removed!"
echo ""

# Remove from /etc/shells
SHELL_PATH="$PREFIX/bin/fufufafa"
if grep -q "$SHELL_PATH" /etc/shells 2>/dev/null; then
    echo "→ Removing fufufafa from /etc/shells..."
    if [[ $EUID -eq 0 ]]; then
        sed -i "\|$SHELL_PATH|d" /etc/shells
        echo "✓ Removed from /etc/shells!"
    else
        echo "⚠ Cannot modify /etc/shells (not root)"
        echo "  Run manually: sudo sed -i '\\|$SHELL_PATH|d' /etc/shells"
    fi
else
    echo "✓ Not in /etc/shells"
fi
echo ""

# Check if user is using fufufafa as default shell
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
if [[ "$CURRENT_SHELL" == *"fufufafa"* ]]; then
    echo "⚠ WARNING: You are currently using fufufafa as your default shell!"
    echo "  Change your shell before logging out:"
    echo "  chsh -s /bin/bash"
    echo ""
fi

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║            Uninstallation Complete! ✓                       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
