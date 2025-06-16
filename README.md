# 🪟 PowerShell to EXE GUI Converter

Easily convert your `.ps1` PowerShell scripts into `.exe` executables using a user-friendly graphical interface. This tool leverages the `ps2exe` module and provides an icon assignment option — all in a few clicks.

![Tool Icon](./assets/icon.png)

## 🚀 Features

- Automatically checks and installs `ps2exe` if not available
- Elevation prompt if admin privileges are required
- GUI to:
  - Select a PowerShell script
  - Select an optional `.ico` icon file
  - Auto-generate the `.exe` output filename
- Displays success or error message after conversion

## 📦 Prerequisites

- Windows 10/11
- PowerShell 5.1+ or PowerShell 7+
- Internet access (to install `ps2exe` module if needed)

## 🛠️ Installation

Clone the repository or download the script:

```bash
git clone https://github.com/yourusername/ps2exe-gui-tool.git
```
Or ![Download the ZIP](https://github.com/yourusername/ps2exe-gui-tool/archive/refs/heads/main.zip)

🧪 Usage

You can either run the script directly or use the precompiled .exe (if provided in the Releases).
▶️ Run via PowerShell
```powershell
.\PS2EXE-GUI.ps1
```

🖥 Run the .exe

Download the .exe version from the Releases, and double-click to launch.

📝 Script Preview
- Launches a GUI to convert .ps1 -> .exe
- Checks & installs ps2exe if needed
- Auto-generates output path

📂 Output

The output .exe will be placed in the same directory as your input .ps1, with the same base name.
📌 Icon

A custom .ico file can be selected to brand your output EXE. Default icon provided in the /assets folder.
📃 License

MIT License

## 👤 Author
[@mell0wx](https://github.com/mell0wx)

