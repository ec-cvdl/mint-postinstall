# Mise à jour du système
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y



# Installation de paquets essentiels
sudo apt remove celluloid -y
sudo apt purge celluloid -y

# Installation de VLC Media Player
sudo apt install vlc -y

# Ajout et vérification de la présence du support Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Vérification de la présence de Libre Office (si non, installation)
if ! command -v libreoffice &> /dev/null; then
    echo -e "\e[32;43mVert sur fond jaune\e[0m" "LibreOffice n'est pas installé. Installation en cours..."
    sudo apt update
    sudo apt install -y libreoffice
else
    echo -e "\e[32;43mVert sur fond jaune\e[0m" "LibreOffice est déjà installé."
fi

# Ajout des raccourcis sur le Bureau
gsettings set org.nemo.desktop home-icon-visible true

echo -e "\e[32;43mVert sur fond jaune\e[0m" "Affichage de la corbeille sur le Bureau"
gsettings set org.nemo.desktop trash-icon-visible true
gsettings set libreoffice-startcenter.desktop true
gsettings set org.nemo.desktop show-home-icon true
gsettings set org.nemo.desktop computer-icon-visible false

echo "[Desktop Entry]
Name=VLC
Exec=vlc
Icon=vlc
Type=Application
Terminal=false" > ~/Bureau/VLC.desktop
echo "[Desktop Entry]
Name=Gestionnaire de mise à jour
Exec=mintupdate
Icon=mintupdate
Type=Application
Terminal=false" > ~/Bureau/Mise-à-jour.desktop
echo "[Desktop Entry]
Name=Firefox
Exec=firefox
Icon=firefox
Type=Application
Terminal=false" > ~/Bureau/Firefox.desktop
echo "[Desktop Entry]
Name=LibreOffice Writer
Exec=libreoffice --writer
Icon=libreoffice-writer
Type=Application
Terminal=false" > ~/Bureau/LibreOffice-Writer.desktop

# Rendre les nouveaux raccourcis exécutables
chmod +x ~/Bureau/*.desktop
nemo -q
nemo &

# Installation des polices Microsoft
echo -e "\e[32;43mVert sur fond jaune\e[0m" "Installation des polices Microsoft pour éviter les problèmes de compatibilité ..."
sudo apt install ttf-mscorefonts-installer -y

