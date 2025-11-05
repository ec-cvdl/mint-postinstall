# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Désinstallation de Celluloid
sudo apt remove celluloid -y
sudo apt purge celluloid -y

# Installation de VLC Media Player
sudo apt install vlc -y

# Vérification du support de Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Ajout des raccourcis sur le Bureau
gsettings set org.nemo.desktop home-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true
gsettings libreoffice-startcenter.desktop true
gsettings set org.nemo. desktop computer-icon-visible false
# Libre Office
echo "[Desktop Entry]
Name=LibreOffice Writer
Exec=libreoffice --writer
Icon=libreoffice-writer
Type=Application
Terminal=false" > "$BUREAU/LibreOffice-Writer.desktop"
# VLC
echo "[Desktop Entry]
Name=VLC
Exec=vlc
Icon=vlc
Type=Application
Terminal=false" > "$BUREAU/VLC.desktop"
# Firefox
echo "[Desktop Entry]
Name=Firefox
Exec=firefox
Icon=firefox
Type=Application
Terminal=false" > "$BUREAU/Firefox.desktop"
# Gestionnaire de Mise à jour
echo "[Desktop Entry]
Name=Gestionnaire de mise à jour
Exec=mintupdate
Icon=mintupdate
Type=Application
Terminal=false" > "$BUREAU/Mise-à-jour.desktop"
# Logithèque
echo "[Desktop Entry]
Name=Logithèque
Exec=mintinstall
Icon=mintinstall
Type=Application
Terminal=false
Categories=System;PackageManager;Settings;" > "$BUREAU/Logithèque.desktop"

# Rendre les raccourcis exécutables
chmod +x "$BUREAU"/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Installation de polices Microsoft additionnels et des codecs multimédia
sudo apt install ubuntu-restricted-extras