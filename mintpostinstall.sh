# Mise à jour du système
echo -e "\e[32;43mMise à jour du système, et récupération des derniers paquets depuis les serveurs officiels ...\e[0m"
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y

# Interface et raccourcis
echo "\e[36mAffichage du dossier personnel sur le Bureau ..."
gsettings set org.nemo.desktop home-icon-visible true

echo -e "\e[32;43mVert sur fond jaune\e[0m" "Affichage de la corbeille sur le Bureau"
gsettings set org.nemo.desktop trash-icon-visible true
nemo -q
nemo &

# Installation de paquets essentiels
echo "\e[36mDésinstallation du lecteur média Celluloid\e[0m"
sudo apt remove celluloid -y
sudo apt purge celluloid -y

# Installation de VLC Media Player
echo -e "\e[32;43mVert sur fond jaune\e[0m" "Installation de VLC Media Player à la place de Celluloid ..."
sudo apt install vlc -y

# Ajout et vérification de la présence du support Flatpak
echo -e "\e[32;43mVert sur fond jaune\e[0m" "Vérification de la présence de Flatpak ..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Vérification de la présence de Libre Office (si non, installation)
echo -e "\e[32;43mVert sur fond jaune\e[0m" "Vérification de la présence de Libre Office ..."
if ! command -v libreoffice &> /dev/null; then
    echo -e "\e[32;43mVert sur fond jaune\e[0m" "LibreOffice n'est pas installé. Installation en cours..."
    sudo apt update
    sudo apt install -y libreoffice
else
    echo -e "\e[32;43mVert sur fond jaune\e[0m" "LibreOffice est déjà installé."
fi

# Installation des polices Microsoft
echo -e "\e[32;43mVert sur fond jaune\e[0m" "Installation des polices Microsoft pour éviter les problèmes de compatibilité ..."
sudo apt install ttf-mscorefonts-installer -y

