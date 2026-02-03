# mint-postinstall
Un script dédié à l'installation et le paramétrage des machines sous Linux Mint auprès des reconditionneurs d'Emmaus Connect en Centre Val-de-Loire ou autres territoires. Ce script peut être utilisé par d'autres structures, dupliqué, commenté et modifié au besoin.

![Capture d'écran du Bureau de Linux Mint un fois le script exécuté](https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/refs/heads/main/screenshot_mint_postinstall.png "Capture d'écran du Bureau de Linux Mint un fois le script exécuté")

## Pré-requis lors de l'installation de Linux Mint 22.2 (Zara) :
1. Téléchargez la dernière version officielle de Linux Mint 22.2 (Zara) via [ce lien](https://www.linuxmint.com/edition.php?id=322)
2. Lors de l'installation, suivez les étapes suivantes :
   - Lancez "Install Linux Mint"
   - Sélectionnez la langue : "Français"
   - Sélectionnez la disposition du clavier : "French - French (legacy, alt)","Français","Français (azerty)"
   - Cochez la case pour l'installation des codecs multimédia
   - Décochez la case "Secure Boot" si proposé
   - Sélectionnez l'option "Effacer le disque et installer Linux Mint" (l'intégralité du disque dur doit être dédiée à Linux Mint, afin d'éviter un dual-boot ou l'apparition du boot menu au démarrage de l'ordinateur)
   - Sélectionnez la zone géographique : "Paris"
   - Entrez les informations du compte : Le nom -> "Utilisateur" ; Mot de passe : "emmaus"
   - Vous pouvez laisser le mot de passe requis au démarrage, donc par défaut lors du lancement.
   - Une fois le système installé, et l'ordinateur redémarré une première fois, fermez la fenêtre de premier lancement de Linux Mint, **sans décocher la case "Afficher cette fenêtre au démarrage" (Important).** Il en va de même, si jamais vous lancez le Gestionnaire de mise à jour, **de ne pas cliquer sur "Valider" lors du premier lancement, afin de laisser un premier niveau d'informations à nos bénéficaires lors de la prise en main du matériel.**
   - Suivez l'une des méthodes d'installation ci-dessous

### Première méthode pour l'installation (mode Terminal et lien raccourci) :
1. Ouvrez l'application "Terminal" sur l'ordinateur
2. Tapez la commande suivante :
  ```bash
curl -sL is.gd/minteccvdl | bash
```
3. Tapez le mot de passe Administrateur ("emmaus") et laissez le script s'exécuter

### Seconde méthode (mode graphique) :
1. Téléchargez le script via [ce lien](https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/refs/heads/main/mintpostinstall.sh) (Clic droit sur le lien, puis "Enregistrer le cible du lien sous"), ou vous pouvez directement télécharger le fichier sur [cette page](https://github.com/ec-cvdl/mint-postinstall/blob/main/mintpostinstall.sh), en cliquant sur l'icône de téléchargement.
2. Ouvrez le dossier du script (en général, dans le dossier "Téléchargements"
3. Faites un clic droit sur le script, puis sur "Propriétés"
4. Dans l'onglet "Permissions", cochez l'option "Autoriser l'exécution du fichier comme un programme"
5. Double cliquez sur le script, puis sélectionnez l'option "Lancer dans le Terminal"
6. Entrez le mot de passe saisi lors de l'installation ("emmaus")

### Ce que fait le script, dans l'ordre d'exécution :
- Mets à jour la machine avec les derniers paquets système
- Supprime les paquets après installation
- Supprime le Terminal de la barre des tâches
- Désinstalle le lecteur média Celluloid
- Installe le lecteur média VLC
- Installe le logiciel Cheese pour la webcam
- Vérifie la présence du support de Flatpak, et si non, l'installe
- Installe le logiciel d'assistance RustDesk
- Lance la Logithèque pendant 35 secondes, pour charger le cache du logiciel
- Vérifie la présence de Libre Office et si non, l'installe
- Génère des raccourcis sur le bureau
- Installe les polices Microsoft pour une meilleure compatibilité avec les documents texte
- Installe des codecs vidéo
- Installe le dictionnaire orthographique Français sous Firefox (activation manuelle à la fin du script)
- Supprime l'historique, ainsi que le cache de Firefox
~~- Supprimer les mots de passe WiFi enregistrés~~
- Supprime le script en lui-même une fois la fenêtre de Firefox fermée

## Comment savoir si le script a fonctionné ?
Pour savoir si le script s'est correctement exécuté, vous devriez trouver, sur le bureau de l'ordinateur, plusieurs raccourcis d'aplications. De plus, une validation manuelle doit se faire à la toute fin du script, juste avant sa suppression. Vous devrez activer le plugin affiché à l'écran. Une fois réalisé, vous n'aurez plus qu'à fermer la fenêtre de Firefox pour confirmer la fin de l'installation, ainsi que la suppression du script sur l'ordinateur.
