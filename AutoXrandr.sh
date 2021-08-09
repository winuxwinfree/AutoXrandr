#!/bin/bash

REQUIRED_PKG="arandr"
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "unknown")
    echo Checking for $REQUIRED_PKG: $PKG_OK
    if [ "" != "$PKG_OK" ]; then
	sudo apt install arandr
    fi
REQUIRED_PKG="libatk-adaptor libgail-common"
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "unknown")
    echo Checking for $REQUIRED_PKG: $PKG_OK
    if [ "" != "$PKG_OK" ]; then
	sudo apt install libatk-adaptor libgail-common
    fi

    sudo apt install -y appmenu-gtk3-module
    #sudo apt install appmenu-gtk2-module
    
sudo arandr

echo -n "#" > /tmp/AutoXrandrLauncher.sh
echo -n "!" >> /tmp/AutoXrandrLauncher.sh
echo "/bin/bash" >> /tmp/AutoXrandrLauncher.sh
echo >> /tmp/AutoXrandrLauncher.sh
echo  "
$(sed -n 4p  /usr/share/dispsetup.sh)
$($xrandr)
" >> /tmp/AutoXrandrLauncher.sh
sudo mv /tmp/AutoXrandrLauncher.sh /usr/local/bin
sudo chmod +x /usr/local/bin/AutoXrandrLauncher.sh
	
if zenity --question --width=440 --title='Autostart' --icon-name='info' --text="Do you want to keep this changes after reboot?"
        then
	echo "[Desktop Entry]
	Type=Application
	Name=AutoXrandrLauncher
	Categories=Settings;DesktopSettings;
	Comment=AutoXrandrAutoBoot
	Exec=/usr/local/bin/AutoXrandrLauncher.sh" > ~/.config/autostart/AutoXrandrLauncher.desktop
	else
	rm -f ~/.config/autostart/AutoXrandrLauncher.desktop
fi

echo "[Desktop Entry]
	Type=Application
	Name=AutoXrandr
	Categories=Settings;DesktopSettings;
	Comment=AutoXrandr
	Icon=preferences-desktop-display-randr
	Exec=/usr/local/bin/AutoXrandr.sh" > ~/.local/share/applications/AutoXrandr.desktop
	
echo "Done, a shortcut has been created in the menu."

