# Chercher TOUTES les occurrences de gnome-terminal dans les configs Cinnamon
echo "=== Recherche dans dconf ==="
dconf dump /org/cinnamon/ | grep -i "terminal"

echo ""
echo "=== Recherche dans les fichiers de config ==="
grep -r "gnome-terminal" ~/.cinnamon/ 2>/dev/null

echo ""
echo "=== Recherche dans gsettings ==="
gsettings list-recursively org.cinnamon | grep -i terminal

echo ""
echo "=== Vérifier les paramètres du panel ==="
dconf read /org/cinnamon/panels/panel1/applets

echo ""
echo "=== Contenu actuel du 2.json ==="
cat ~/.cinnamon/configs/grouped-window-list@cinnamon.org/2.json | grep -A2 -B2 "pinned"
