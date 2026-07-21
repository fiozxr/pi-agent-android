#!/data/data/com.termux/files/usr/bin/bash
#
# setup.sh — Automated installer for PI Coding Agent CLI on Termux
# Sets up a proot Ubuntu environment, installs Node.js and PI CLI,
# and configures auto-login into Ubuntu on every Termux launch.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/fiozxr/pi-agent-android/main/setup.sh | bash
#

set -e  # Exit immediately if a command fails

echo "=================================================="
echo "  PI CLI Setup — Termux + Ubuntu (proot-distro)"
echo "=================================================="
echo ""

# ---------------------------------------------------------
# Step 1: Update Termux and install proot-distro + nano
# ---------------------------------------------------------
echo "[1/5] Updating Termux packages..."
apt update -y

echo "[2/5] Installing proot-distro fahhhh....."
apt install -y proot-distro nano

# ---------------------------------------------------------
# Step 2: Install Ubuntu via proot-distro
# ---------------------------------------------------------
echo "[3/5] Installing Ubuntu (proot-distro)..."
if proot-distro list --installed 2>/dev/null | grep -q "ubuntu"; then
    echo "Ubuntu is already installed, skipping..."
else
    proot-distro install ubuntu
fi

# ---------------------------------------------------------
# Step 3: Configure Termux .bashrc for auto-login into Ubuntu
# ---------------------------------------------------------
echo "[4/5] Configuring ~/.bashrc for auto-login into Ubuntu..."

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! grep -q "proot-distro login ubuntu" "$BASHRC"; then
    {
        echo ""
        echo "# Auto-login into Ubuntu (added by PI CLI setup.sh)"
        echo "clear"
        echo "proot-distro login ubuntu"
    } >> "$BASHRC"
    echo "Added auto-login entries to .bashrc"
else
    echo ".bashrc already configured, skipping..."
fi

# ---------------------------------------------------------
# Step 4: Log into Ubuntu and install Node.js + PI CLI
# ---------------------------------------------------------
echo "[5/5] Entering Ubuntu to install Node.js and PI CLI..."

proot-distro login ubuntu -- bash -c "
    set -e
    echo '--- Updating Ubuntu packages ---'
    apt update -y && apt upgrade -y

    echo '--- Installing Node.js ---'
    apt install -y nodejs npm

    echo '--- Installing PI Coding Agent CLI ---'
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent

    clear
    echo ''
    echo '=================================================='
    echo '  ✅ PI CLI installed successfully!'
    echo '  Run it anytime inside Ubuntu using:'
    echo ''
    echo '      pi'
    echo ''
    echo '=================================================='
"

# ---------------------------------------------------------
# Done
# ---------------------------------------------------------
clear
echo "=================================================="
echo "  🎉 Setup complete!"
echo ""
echo "  Restart Termux and you"
echo "  will be logged into Ubuntu automatically."
echo ""
echo "  Once inside Ubuntu, run:"
echo ""
echo "      pi"
echo ""
echo "  to start the PI Coding Agent."
echo "=================================================="
