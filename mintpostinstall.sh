# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Suppression de l'application Terminal de la barre des tâches
gsettings set org.cinnamon favorite-apps "$(gsettings get org.cinnamon favorite-apps | sed "s/'org.gnome.Terminal.desktop',\? ?//; s/, ?'org.gnome.Terminal.desktop'//; s/$$ , /\[/; s/, $$ /]/")"

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

# Création du dossier .mozzila dans le dossier personnel
firefox & sleep 3 && pkill -f firefox

# Installation du dictionnaire Français sous Firefox et activation
# curl -L -o /tmp/dict.xpi "https://github.com/ec-cvdl/mint-postinstall/blob/main/dictionnaire_francais1-7.0b.xpi" && \
# sudo mkdir -p /usr/lib/firefox/distribution/extensions && \
# sudo cp /tmp/dict.xpi /usr/lib/firefox/distribution/extensions/dictionnaire-francais@mozilla.org.xpi && \
# pkill firefox && sleep 2 && firefox &

# Installation de polices Microsoft et codecs vidéo
sudo apt install -y ubuntu-restricted-extras

# Suppression de tous les mots de passe Wi-Fi enregistrés
for conn in $(nmcli -t -f NAME,TYPE connection show | grep wifi | cut -d: -f1); do
    sudo nmcli connection modify "$conn" wifi-security.psk ""
    sudo nmcli connection modify "$conn" 802-11-wireless-security.psk ""
done
sudo nmcli connection reload

# Suppression du script
echo "L'installation s'est déroulée avec succès, appuyez sur la touche Entrée pour terminer l'installation ..."
read

SCRIPT_PATH="$(realpath "$0")"
rm -- "$SCRIPT_PATH"
