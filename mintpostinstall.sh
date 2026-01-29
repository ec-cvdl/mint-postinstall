# Déplacement dans le dossier Téléchargements
cd /home/user/Téléchargements 2>/dev/null || cd /home/utilisateur/Téléchargements

# Fermeture de Mint Welcome
pkill mintwelcome

# Fermeture de Mint-Update
pkill mintUpdate

# Mise à jour du système
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Suppression de l'application Terminal de la barre des tâches
#!/bin/bash

# Script de post-installation pour désépingler le terminal
CONFIG_FILE="$HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "✗ Fichier de configuration non trouvé : $CONFIG_FILE"
    exit 1
fi

BACKUP_FILE="${CONFIG_FILE}.backup-$(date +%Y%m%d_%H%M%S)"
cp "$CONFIG_FILE" "$BACKUP_FILE"
python3 << 'EOF'
import json
import os

config_file = os.path.expanduser("~/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json")

try:
    with open(config_file, 'r') as f:
        data = json.load(f)
    
    print(f"  Contenu actuel de pinned-apps:")
    if 'pinned-apps' in data:
        print(f"    value: {data['pinned-apps'].get('value', [])}")
        print(f"    default: {data['pinned-apps'].get('default', [])}")
    
    # Retirer le terminal de 'value'
    if 'pinned-apps' in data and 'value' in data['pinned-apps']:
        original = data['pinned-apps']['value']
        filtered = [app for app in original if app not in ['gnome-terminal.desktop', 'org.gnome.Terminal.desktop']]
        data['pinned-apps']['value'] = filtered
        print(f"\n  Nouveau value: {filtered}")
    
    # Retirer le terminal de 'default'
    if 'pinned-apps' in data and 'default' in data['pinned-apps']:
        original_default = data['pinned-apps']['default']
        filtered_default = [app for app in original_default if app not in ['gnome-terminal.desktop', 'org.gnome.Terminal.desktop']]
        data['pinned-apps']['default'] = filtered_default
        print(f"  Nouveau default: {filtered_default}")
    
    with open(config_file, 'w') as f:
        json.dump(data, f, indent=4)
    
    print("\n✓ Fichier modifié avec succès")
    
except Exception as e:
    print(f"\n✗ Erreur : {e}")
    exit(1)
EOF

if [ $? -ne 0 ]; then
    echo "✗ Erreur lors de la modification"
    exit 1
fi
sudo sed -i 's/"default": \["nemo.desktop", "firefox.desktop", "org.gnome.Terminal.desktop"\]/"default": ["nemo.desktop", "firefox.desktop"]/' /usr/share/cinnamon/applets/grouped-window-list@cinnamon.org/settings-schema.json 2>/dev/null

dbus-send --session --dest=org.Cinnamon.LookingGlass --type=method_call \
    /org/Cinnamon/LookingGlass org.Cinnamon.LookingGlass.ReloadExtension \
    string:'grouped-window-list@cinnamon.org' string:'APPLET' 2>/dev/null

if [ $? -ne 0 ]; then
    killall -9 cinnamon 2>/dev/null
    sleep 2
    cinnamon &
    sleep 3
fi

# Désinstallation de Celluloid
sudo apt remove celluloid -y
sudo apt purge celluloid -y

# Installation de VLC Media Player
sudo apt install vlc -y

# Installation de Cheese (Webcam)
sudo apt install cheese -y

# Installation d'Okular
# sudo apt install okular -y
# xdg-mime default okular.desktop application/pdf
# xdg-mime query default application/pdf

# Vérification du support de Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installation de RustDesk via Flatpak
flatpak install -y --noninteractive flathub com.rustdesk.RustDesk

# Ouverture de la Logithèque pour charger le cache
mintinstall & sleep 35 && pkill -f mintinstall

# Ajout des raccourcis sur le Bureau
gsettings set org.nemo.desktop home-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true

# Créer les lanceurs personnalisés
BUREAU="$HOME/Bureau"

# Fonction pour créer les raccourcis Bureau
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
create_launcher "LibreOffice Writer" "libreoffice --writer" "libreoffice-writer"
create_launcher "LibreOffice Calc" "libreoffice --calc" "libreoffice-calc"
create_launcher "LibreOffice Impress" "libreoffice --impress" "libreoffice-impress"
create_launcher "VLC" "vlc" "vlc"
create_launcher "Firefox" "firefox" "firefox"
create_launcher "Logithèque" "mintinstall" "mintinstall"
create_launcher "Gestionnaire de mise à jour" "mintupdate" "software-update-available"
create_launcher "Lecteur de documents PDF" "xreader" "xreader"
create_launcher "Message d'accueil" "mintwelcome" "mintwelcome"

# Rendre les raccourcis exécutables
chmod +x ~/Bureau/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Changement du fond d'écran
gsettings set org.cinnamon.desktop.background picture-uri "file:///usr/share/backgrounds/linuxmint-wallpapers/jvasek_xmas_bokeh.jpg"

# Application du thème Clair
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Sand"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Sand"
gsettings set org.cinnamon.theme name "Mint-Y"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Aqua"

# Création du dossier .mozzila dans le dossier personnel
firefox & sleep 3 && pkill -f firefox

# Installation du dictionnaire Français sous Firefox
wget https://github.com/ec-cvdl/mint-postinstall/raw/refs/heads/main/fr-dicollecte@dictionaries.addons.mozilla.org.xpi
sudo mv "/home/utilisateur/Téléchargements/fr-dicollecte@dictionaries.addons.mozilla.org.xpi" ~/.mozilla/firefox/*.default-release/extensions
sudo mv "/home/user/Téléchargements/fr-dicollecte@dictionaries.addons.mozilla.org.xpi" ~/.mozilla/firefox/*.default-release/extensions
pkill -f firefox || true
firefox --headless &
sleep 5
pkill -f firefox

# Téléchargement du livret d'accompagnement livret en PDF, puis déplacement sur le Bureau et dans le dossier Documents
wget https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/main/aide.pdf
cp ~/Documents/aide.pdf
mv ~/Desktop/aide.pdf

# Installation de polices Microsoft et codecs vidéo
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-restricted-extras

# Réaffichage du message de bienvenue de Linux Mint
sudo rm -rf /home/utilisateur/.linuxmint
sudo rm -rf /home/user/.linuxmint

# Ouverture de Firefox pour l'activation du l'activation du dictionnaire
firefox https://addons.mozilla.org/fr/firefox/addon/dictionnaire-fran%C3%A7ais1/

# Supression de l'historique et du cache de Firefox
rm -rf ~/.mozilla/firefox/*.default-release/places.sqlite
rm -rf ~/.mozilla/firefox/*.default-release/cookies.sqlite
rm -rf ~/.mozilla/firefox/*.default-release/cache2/

# Suppression de tous les mots de passe Wi-Fi enregistrés (dans une future mise à jour)

# Suppression du script
SCRIPT_PATH="$(realpath "$0")"
rm -- "$SCRIPT_PATH"
