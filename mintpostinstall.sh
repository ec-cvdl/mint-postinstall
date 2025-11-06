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

# Test Raccourcis
#!/bin/bash

# 1. Afficher les icônes système
gsettings set org.nemo.desktop trash-icon-visible true
gsettings set org.nemo.desktop home-icon-visible true

# 2. Créer les lanceurs personnalisés
BUREAU="$HOME/Bureau"

# Fonction pour créer un lanceur
creer_lanceur() {
    local nom=$1
    local exec=$2
    local icone=$3
    cat > "$BUREAU/$nom.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$nom
Exec=$exec
Icon=$icone
Terminal=false
EOF
    chmod +x "$BUREAU/$nom.desktop"
}

# Créer les lanceurs
creer_lanceur "LibreOffice Writer" "libreoffice --writer" "libreoffice-writer"
creer_lanceur "VLC" "vlc" "vlc"
creer_lanceur "Firefox" "firefox" "firefox"
creer_lanceur "Logithèque" "mintinstall" "software-manager"
creer_lanceur "Gestionnaire de mise à jour" "mintupdate" "software-update-available"

echo "Raccourcis configurés sur le bureau."


# Rendre les raccourcis exécutables
chmod +x ~/Bureau/*.desktop

# Redémarrage de l'explorateur
nemo -q

# Installation de polices Microsoft et codecs vidéo
sudo apt install -y ubuntu-restricted-extras