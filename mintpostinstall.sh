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
Name=Libre Office
Exec=libreoffice %U
Icon=libreoffice-main
Type=Application
Terminal=false
Categories=Office

# Rendre les raccourcis exécutables
chmod +x ~/Bureau/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Installation de polices Microsoft et codecs vidéo
sudo apt install ubuntu-restricted-extras