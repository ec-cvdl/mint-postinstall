# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Désinstallation de Celluloid
sudo apt remove celluloid -y
sudo apt purge celluloid -y

#Installation de VLC Media Player
sudo apt install vlc -y

# Vérification du support de Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Ajout des raccourcis sur le Bureau
gsettings set org.nemo.desktop home-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true
# Libre Office
[Desktop Entry]
Version=1.0
Type=Application
Name=LibreOffice 
Comment=Ouvrir LibreOffice 
Exec=libreoffice 
Icon=libreoffice
Path=
Terminal=false
StartupNotify=false
# VLC
[Desktop Entry]
Version=1.0
Type=Application
Name=VLC
Comment=Lecteur multimédia VLC
Exec=vlc
Icon=vlc
Path=
Terminal=false
StartupNotify=false
# Logithèque
[Desktop Entry]
Version=1.0
Type=Application
Name=Logithèque
Comment=Gestionnaire de logiciels Linux Mint
Exec=mintinstall
Icon=software-manager
Path=
Terminal=false
StartupNotify=false
# Gestionnaire de mise à jour
[Desktop Entry]
Version=1.0
Type=Application
Name=Gestionnaire de mise à jour
Comment=Gestionnaire de mise à jour Linux Mint
Exec=mintupdate
Icon=software-update-available
Path=
Terminal=false
StartupNotify=false
# Firefox
[Desktop Entry]
Version=1.0
Type=Application
Name=Firefox
Comment=Navigateur web Firefox
Exec=firefox
Icon=firefox
Path=
Terminal=false
StartupNotify=false

# Rendre les raccourcis exécutables
chmod +x ~/Bureau/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Installation de polices Microsoft et codecs vidéo
sudo apt install ubuntu-restricted-extras