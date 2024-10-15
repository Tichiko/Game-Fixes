#!/bin/bash

# Path to Engine.ini File
Engine_ini="/home/deck/.local/share/Steam/steamapps/compatdata/1790600/pfx/drive_c/users/steamuser/AppData/Local/SparkingZERO/Saved/Config/Windows/Engine.ini"
# Target Framerate Per Second
FPS_Target="40"

# Information about Script
echo "
**************************************************************************************
*                                                                                    *
*            60 FPS To 40 FPS Modification For Dragon Ball: Sparking Zero            *
*                                                                                    *
**************************************************************************************

This Script is made to make Dragon Ball: Sparking Zero run at full speed at 40FPS
instead of requiring 60FPS to do so. While This Script Should work on many linux
computers that are running the Steam Version of this game this Script was created
with the SteamDeck in mind.

This script was created using information from a video made by Steam Deck HQ
Who was informed of this by Twitter(X) user Jerk48

Press Any Key to Continue...
"

read -n 1 -s

echo 'Editing the "Engine.ini" File for Dragon Ball: Sparking Zero'

# Actual Editing of Engine.ini File
echo "[/script/engine.engine]
FixedFrameRate=$FPS_Target

[SystemSettings]
bUseFixedFrameRate=True
bSmoothFrameRate=False
FixedFrameRate=$FPS_Target
FrameRateLimit=$FPS_Target" >> ~/.local/share/Steam/steamapps/compatdata/1790600/pfx/drive_c/users/steamuser/AppData/Local/SparkingZERO/Saved/Config/Windows/Engine.ini

echo '
The Modification has been complete feel free to double check in the following location

~/.local/share/Steam/steamapps/compatdata/1790600/pfx/drive_c/users/steamuser/AppData/Local/SparkingZERO/Saved/Config/Windows/Engine.ini

Press Enter to exit...
'

read -n 1 -s

exit
