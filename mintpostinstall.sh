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

# Installation du dictionnaire Français sous Firefox et activation
wget -O /tmp/fr-FR.xpi "wget -O /tmp/fr-FR.xpi "https://addons.mozilla.org/firefox/downloads/latest/french-dictionary/latest.xpi""
echo 'user_pref("spellchecker.dictionary", "fr-FR");' >> "$PROFILE/prefs.js"
rm /tmp/french-dictionary.xpi

# Installation de polices Microsoft et codecs vidéo
sudo apt install -y ubuntu-restricted-extras
firefox --install-addon /tmp/french-dictionnary.xpi


# Suppression du script
sudo rm -- "$0" -y
