# Run PI AGENT CLI on Android 

This guide shows you how to run the **PI Coding Agent CLI** on your Android device using [Termux](https://f-droid.org/en/packages/com.termux/) and a proot Ubuntu environment.

You have two options:

- ⚡ **Option A — Quick Setup** using a single `setup.sh` script
- 🧑‍💻 **Option B — Manual Step-by-Step** (recommended if you want to understand each step, or the script doesn't work on your device)

---

## ✅ Requirements

- An Android device
- [Termux](https://f-droid.org/en/packages/com.termux/) installed **from F-Droid** (not the Play Store version, which is outdated and unmaintained)
- A stable internet connection ( ~700MB )

---

## ⚡ Option A: Quick Setup (setup.sh)

If you just want to get up and running fast, download and run the setup script:

```bash
curl -fsSL https://github.com/fiozxr/pi-agent-android/blob/main/setup.sh | bash
```
> This script automates all the steps from Option B below. Use Option B if you'd like more control or want to troubleshoot manually.

---

## 🧑‍💻 Option B: Step-by-Step Guide (Recommended)

### 1. Install Termux from F-Droid

Download and install Termux here: [https://f-droid.org/en/packages/com.termux/](https://f-droid.org/en/packages/com.termux/)

> ⚠️ Do **not** install Termux from the Google Play Store — it's outdated and no longer supported.

### 2. Update Termux and install `proot-distro`

```bash
apt update -y && apt upgrade -y
apt install proot-distro -y
```

### 3. Install and log into Ubuntu

```bash
proot-distro install ubuntu
proot-distro login ubuntu
```

This gives you a full* Ubuntu environment running inside Termux.

### 4. Update Ubuntu and install Node.js

```bash
apt update -y && apt install nodejs -y
```

### 5. Install PI CLI

You can install PI using **either** of the following methods:

**Option 1 — Official install script:**
```bash
curl -fsSL https://pi.dev/install.sh | sh
```

**Option 2 — via npm:**
```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

### 6. Run PI

```bash
pi
```

That's it — PI CLI is now running inside your Ubuntu environment on Termux! 🎉
Run /login and set you API provider and KEY or LOGIN wih 0Auth.

---

## 💡 Free Tips & Quality-of-Life Tweaks

**1. Auto-login to Ubuntu when you open Termux (Recommended)**

Edit your Termux `.bashrc` so you're dropped straight into your Ubuntu shell every time you open the app:

```bash
nano ~/.bashrc
```

Add these lines at the end:

```bash
clear
proot-distro login ubuntu
```

Save and exit (`Ctrl+O`, `Enter`, then `Ctrl+X`). Now every new Termux session will clear the screen and log you directly into Ubuntu — no need to type `proot-distro login ubuntu` manually each time.

**2. Keep Termux awake during long sessions**

Enable a wake lock so Android doesn't kill your Termux session in the background:

```bash
termux-wake-lock
```

**3. Storage access**

If you need to access your phone's storage (Downloads, etc.) from Termux:

```bash
termux-setup-storage
```

---

## 🔗 Related Agents

This guide is part of a series covering how to run popular AI coding agents on Android/Termux, including:

- Claude
- Codex
- Antigravity
- PI ✅ *(this guide)*
- ...and more coming soon

---

## 📝 Notes

- Performance will depend on your device's RAM and CPU — flagship phones will run noticeably smoother.
- If a command fails, try running `apt update -y && apt upgrade -y` again inside Ubuntu before retrying.
