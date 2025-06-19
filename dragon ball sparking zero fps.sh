#!/bin/bash

# Path to Engine.ini
Engine_ini="$HOME/.local/share/Steam/steamapps/compatdata/1790600/pfx/drive_c/users/steamuser/AppData/Local/SparkingZERO/Saved/Config/Windows/Engine.ini"

# File existence check before doing anything else
if [[ ! -f "$Engine_ini" ]]; then
    echo "❌ Error: Engine.ini file not found at:"
    echo "$Engine_ini"
    exit 1
fi

# Detect existing FixedFrameRate
existing_fps=$(grep -E '^FixedFrameRate=' "$Engine_ini" | head -n1 | cut -d'=' -f2)

# Clear screen and show banner with current FPS
clear
echo "
**************************************************************************************
*                                                                                    *
*            Dragon Ball: Sparking Zero FPS Modifier                                 *
*                                                                                    *
**************************************************************************************

Current Engine.ini Framerate Setting: ${existing_fps:-Not Set}

This script modifies the game to run at a lower framerate than the default 60 FPS,
which helps improve performance on devices like the Steam Deck.

"

# FPS selection menu
echo "Choose your desired framerate:"
echo "1) 60 FPS"
echo "2) 50 FPS"
echo "3) 45 FPS"
echo "4) 40 FPS (Recommended)"
echo "5) 30 FPS"
echo "6) Custom"
echo

read -rp "Enter your choice (1-6): " choice

case "$choice" in
    1) FPS_Target=60 ;;
    2) FPS_Target=50 ;;
    3) FPS_Target=45 ;;
    4) FPS_Target=40 ;;
    5) FPS_Target=30 ;;
    6) 
        read -rp "Enter custom framerate (e.g., 37.5): " custom_fps
        if [[ "$custom_fps" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
            FPS_Target="$custom_fps"
        else
            echo "❌ Invalid input. Exiting..."
            exit 1
        fi
        ;;
    *) 
        echo "❌ Invalid selection. Exiting..."
        exit 1
        ;;
esac

echo
echo "You selected: $FPS_Target FPS"
echo "Press any key to continue..."
read -n 1 -s

# Confirm overwrite if a value is already set
if [[ -n "$existing_fps" ]]; then
    echo
    echo "⚠️  Detected existing FixedFrameRate setting: ${existing_fps} FPS"
    echo "Do you want to overwrite it with ${FPS_Target} FPS? (y/n)"
    read -r choice

    if [[ "$choice" != [Yy] ]]; then
        echo "❌ Aborted: No changes were made."
        exit 0
    fi
fi

# Create a backup
cp "$Engine_ini" "${Engine_ini}.bak"
echo "🗂  Backup created: ${Engine_ini}.bak"

# Remove old frame rate settings
sed -i '/^\[\/script\/engine.engine\]/,/^$/d' "$Engine_ini"
sed -i '/^\[SystemSettings\]/,/^$/d' "$Engine_ini"

# Append new settings
cat <<EOF >> "$Engine_ini"

[/script/engine.engine]
FixedFrameRate=$FPS_Target

[SystemSettings]
bUseFixedFrameRate=True
bSmoothFrameRate=False
FixedFrameRate=$FPS_Target
FrameRateLimit=$FPS_Target
EOF

echo "
✅ FPS modification applied: ${FPS_Target} FPS

Check the file here if you'd like to verify:
$Engine_ini

Press Enter to exit...
"
read
