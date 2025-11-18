# mint-postinstall
Un script dédié à l'installation et le paramétrage des machines sous Linux Mint auprès des reconditionneurs d'Emmaus Connect en Centre Val-de-Loire. Ce script peut être utilisé par d'autres régions, dupliqué, commenté et modifié au besoin.

### Première méthode pour l'installation :
1. Téléchargez le script via [ce lien](https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/refs/heads/main/mintpostinstall.sh)
2. Ouvrez le dossier du script (en général, dans le dossier "Téléchargements"
3. Faites un clic droit sur le script, puis sur "Propriétés"
4. Dans l'onglet "Permissions", cochez l'option "Autoriser l'exécution du fichier comme un programme"
5. Double cliquez sur le script, puis sélectionnez l'option "Lancer dans le Terminal"
6. Entrez le mot de passe saisi lors de l'installation (généralement "emmaus")

### Seconde méthode (en ligne de commande) :
1. Ouvrez l'application "Terminal" sur l'ordinateur
2. Télécharger le fichier d'installation depuis Github
  `wget https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/refs/heads/main/mintpostinstall.sh`
3. Rendez le script exécutable avec les droits adminstrateur avec
   `sudo chmod +x mintpostinstall.sh`
4. Exécutez le script avec la commande :
  `sudo ./mintpostinstall.sh`

### Ce que fait le script, dans l'ordre d'exécution :
- Mets à jour la machine avec les derniers paquets système
- Supprime les paquets après installation
- Désinstalle le lecteur média Celluloid
- Installe le lecteur média VLC
- Vérifie la présence du support de Flatpak, et si non, l'installe
- Vérifie la présence de Libre Office et si non, l'installe
- Génère des raccourcis sur le bureau
- Installe les polices Microsoft pour une meilleure compatibilité avec les documents texte
- Installe des codecs vidéo
- Supprime toutes les connexions réseau
- Supprime le script en lui-même
