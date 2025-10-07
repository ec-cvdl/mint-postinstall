# mint-postinstall
Un script dédié à l'installation et le paramétrage des machines sous Linux Mint auprès des reconditionneurs d'Emmaus Connect en Centre Val-de-Loire. Ce script peut être utilisé par d'autres régions, dupliqué, commenté et modifié au besoin.

### Voici les étapes pour procéder à son installation :
1. Ouvrez l'application "Terminal" sur l'ordinateur
2. Télécharger le fichier d'installation depuis Github
  `wget https://github.com/ec-cvdl/mint-postinstall/blob/main/mintpostinstall.sh`
3. Rendez le script exécutable avec les droits adminstrateur avec
   `sudo chmod +x mintpostinstall.sh`
4. Exécutez le script avec la commande :
  `sudo ./mintpost-install.sh`
### Ce que fait le script, dans l'ordre d'exécution :
- Mets à jour la machine avec les derniers paquets système
- Supprime les paquets après installation
- Affichage du dossier personnel et de la corbeille sur le bureau
- Désinstalle le lecteur média Celluloid
- Installe le lecteur média VLC
- Vérifie la présence du support de Flatpak, et si non, l'installe
- Vérifie la présence de Libre Office et si non, l'installe
- Installe les polices Microsoft pour une meilleure compatibilité avec les documents texte
