# 1. Vérifier le contenu actuel de votre 2.json
cat ~/.cinnamon/configs/grouped-window-list@cinnamon.org/2.json | grep -A3 "pinned-apps"

# 2. Forcer la réécriture avec les bonnes valeurs
python3 << 'EOF'
import json
import os

config_file = os.path.expanduser("~/.cinnamon/configs/grouped-window-list@cinnamon.org/2.json")

with open(config_file, 'r') as f:
    data = json.load(f)

# Forcer explicitement la valeur
data['pinned-apps'] = {
    "type": "generic",
    "default": ["nemo.desktop", "firefox.desktop", "org.gnome.Terminal.desktop"],
    "value": ["nemo.desktop", "firefox.desktop"]
}

with open(config_file, 'w') as f:
    json.dump(data, f, indent=4)

print("Configuration forcée")
EOF

# 3. Supprimer le cache de Cinnamon
rm -rf ~/.cinnamon/configs.bak
rm -rf /tmp/cinnamon-*

# 4. Redémarrer Cinnamon COMPLÈTEMENT
cinnamon --replace &
