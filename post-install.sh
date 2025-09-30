# Mise à jour du système
echo "Mise à jour du système, et récupération des derniers paquets depuis les serveurs officiels ..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y

# Interface et raccourcis
echo "Affichage de la corbeille sur le Bureau"
gsettings set org.nemo.desktop trash-icon-visible true
nemo -q
nemo &

# Installation de paquets essentiels
echo "Désinstallation du lecteur média Celluloid"
sudo apt remove celluloid -y
sudo apt purge celluloid -y

# Installation de VLC Media Player
echo "Installation de VLC Media Player à la place de Celluloid ..."
sudo apt install vlc -y

# Ajout et vérification de la présence du support Flatpak
echo "Vérification de la présence de Flatpak ..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Vérification de la présence de Libre Office (si non, installation)
echo "Vérification de la présence de Libre Office ..."
if ! command -v libreoffice &> /dev/null; then
    echo "LibreOffice n'est pas installé. Installation en cours..."
    sudo apt update
    sudo apt install -y libreoffice
else
    echo "LibreOffice est déjà installé."
fi

# Installation des polices Microsoft
echo "Installation des polices Microsoft pour éviter les problèmes de compatibilité ..."
sudo apt install ttf-mscorefonts-installer -y

