# Fermeture de Mint-Update
pkill mintUpdate

# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Suppression de l'application Terminal de la barre des tâches


# Désinstallation de Celluloid
sudo apt remove celluloid -y
sudo apt purge celluloid -y

#Installation de VLC Media Player
sudo apt install vlc -y

# Vérification du support de Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installation de RustDesk via Flatpak
flatpak install rustdesk -y

# Ouverture de la Logithèque pour charger le cache
mintinstall & sleep 30 && pkill -f mintinstall

# Ajout des raccourcis sur le Bureau
gsettings set org.nemo.desktop home-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true

# Créer les lanceurs personnalisés
BUREAU="$HOME/Bureau"

# Fonction pour créer un raccourci
create_launcher() {
    local name=$1
    local exec=$2
    local icon=$3
    cat > "$BUREAU/$name.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$name
Exec=$exec
Icon=$icon
Terminal=false
EOF
    chmod +x "$BUREAU/$name.desktop"
}

# Créer les lanceurs
create_launcher "LibreOffice" "libreoffice" "libreoffice"
create_launcher "VLC" "vlc" "vlc"
create_launcher "Firefox" "firefox" "firefox"
create_launcher "Logithèque" "mintinstall" "mintinstall"
create_launcher "Gestionnaire de mise à jour" "mintupdate" "software-update-available"

# Rendre les raccourcis exécutables
chmod +x ~/Bureau/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Création du dossier .mozzila dans le dossier personnel
firefox & sleep 3 && pkill -f firefox

# Installation du dictionnaire Français sous Firefox
wget https://github.com/ec-cvdl/mint-postinstall/raw/refs/heads/main/fr-dicollecte@dictionaries.addons.mozilla.org.xpi
sudo mv "/home/utilisateur/Téléchargements/fr-dicollecte@dictionaries.addons.mozilla.org.xpi" ~/.mozilla/firefox/*.default-release/extensions
sudo mv "/home/user/Téléchargements/fr-dicollecte@dictionaries.addons.mozilla.org.xpi" ~/.mozilla/firefox/*.default-release/extensions
sudo mv "/home/admin/Téléchargements/fr-dicollecte@dictionaries.addons.mozilla.org.xpi" ~/.mozilla/firefox/*.default-release/extensions
pkill -f firefox || true
firefox --headless &
sleep 5
pkill -f firefox

# Installation de polices Microsoft et codecs vidéo
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-restricted-extras

# Réaffichage du message de bienvenue de Linux Mint
sudo rm -rf /home/utilisateur/.linuxmint
sudo rm -rf /home/user/.linuxmint
sudo rm -rf /home/admin/.linuxmint

# Ouverture de Firefox pour l'activation du l'activation du dictionnaire
firefox https://addons.mozilla.org/fr/firefox/addon/dictionnaire-fran%C3%A7ais1/

# Supression de l'historique et du cache de Firefox
rm -rf ~/.mozilla/firefox/*.default-release/places.sqlite
rm -rf ~/.mozilla/firefox/*.default-release/cookies.sqlite
rm -rf ~/.mozilla/firefox/*.default-release/cache2/

# Suppression de tous les mots de passe Wi-Fi enregistrés
sudo nmcli connection show | grep wifi | awk '{print $1}' | xargs -I {} nmcli connection delete {}
sudo wpa_cli list_networks | awk 'NR>1 {print $1}' | xargs -I {} sudo wpa_cli remove_network {}
sudo rm /etc/NetworkManager/system-connections/*
sudo rm /etc/wpa_supplicant/wpa_supplicant.conf

# Suppression du script
SCRIPT_PATH="$(realpath "$0")"
rm -- "$SCRIPT_PATH"
