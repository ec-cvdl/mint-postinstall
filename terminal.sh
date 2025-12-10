# 1. Sauvegarder et supprimer complètement le dossier de config de l'applet
mv ~/.cinnamon/configs/grouped-window-list@cinnamon.org ~/.cinnamon/configs/grouped-window-list@cinnamon.org.backup

# 2. Tuer Cinnamon complètement
killall -9 cinnamon

# 3. Attendre 2 secondes
sleep 2

# 4. Relancer Cinnamon (il va recréer la config par défaut)
cinnamon &

# 5. Attendre que Cinnamon démarre
sleep 5

# 6. Maintenant modifier le fichier fraîchement créé
python3 << 'EOF'
import json
import os
import time

# Attendre que le fichier soit créé
config_file = os.path.expanduser("~/.cinnamon/configs/grouped-window-list@cinnamon.org/2.json")

for i in range(10):
    if os.path.exists(config_file):
        break
    time.sleep(1)

if os.path.exists(config_file):
    with open(config_file, 'r') as f:
        data = json.load(f)
    
    if 'pinned-apps' in data and 'value' in data['pinned-apps']:
        # Retirer le terminal
        data['pinned-apps']['value'] = [app for app in data['pinned-apps']['value'] if app != 'gnome-terminal.desktop']
        
    with open(config_file, 'w') as f:
        json.dump(data, f, indent=4)
    
    print("✓ Config modifiée")
else:
    print("✗ Fichier non créé")
EOF

# 7. Redémarrer Cinnamon une dernière fois
killall -9 cinnamon
cinnamon &
