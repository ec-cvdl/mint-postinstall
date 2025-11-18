# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Suppression de l'application Terminal de la barre des tâches
gsettings set org.cinnamon panel-launchers "$(gsettings get org.cinnamon panel-launchers | sed -e "s/, *'gnome-terminal.desktop'//g" -e "s/'gnome-terminal.desktop', *//g" -e "s/'gnome-terminal.desktop'//g")"

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
curl -L -o /tmp/dict.xpi "https://github.com/ec-cvdl/mint-postinstall/blob/main/dictionnaire_francais1-7.0b.xpi" && \
sudo mkdir -p /usr/lib/firefox/distribution/extensions && \
sudo cp /tmp/dict.xpi /usr/lib/firefox/distribution/extensions/dictionnaire-francais@mozilla.org.xpi && \
pkill firefox && sleep 2 && firefox &

# Installation de polices Microsoft et codecs vidéo
sudo apt install -y ubuntu-restricted-extras

# Suppression du mot de passe Wifi
sudo nmcli connection modify "$(nmcli -t -f NAME,DEVICE connection show --active

# Suppression du script
sudo rm -- "$0" -y
