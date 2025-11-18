#!/usr/bin/env bash
#
# install_french_dictionary.sh
#
# Automatisation de l'installation du dictionnaire français pour Firefox
# sur Linux Mint 22.2 (ou tout dérivé Ubuntu 2.04).
#
# • Téléchargement du .xpi depuis le dépôt GitHub
# • Installation via le Policy Engine de Firefox (global, sans lancer le navigateur)
# • Activation par défaut de l'extension
#
# À exécuter avec sudo ou en tant que root.
# --------------------------------------------------------

set -euo pipefail

# ------------------------------------------
# 1️⃣ Variables configurables
# --------------------------------------------------------------

# URL du fichier .xpi (version actuelle du projet)
XPI_URL="https://raw.githubusercontent.com/ec-cvdl/mint-postinstall/main/dictionnaire_francais1-7.0b.xpi"

# Nom de l'extension tel qu'il apparaît dans le manifest.json
# (c’est l’identifiant interne utilisé par Firefox)
EXTENSION_ID="dictionnaire-francais@ec-cvdl.github.com"

# Répertoire où Firefox lit ses politiques globales
POLICIES_DIR="/usr/lib/firefox/distribution"

# Chemin complet du fichier de politique JSON (créé ou mis à jour)
POLICIES_JSON="${POLICIES_DIR}/policies.json"

# Répertoire temporaire de travail
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT

# ------------------------------------------
# 2️⃣ Téléchargement du .xpi
# ----------------------------------------

echo "🔽 Téléchargement du dictionnaire depuis ${XPI_URL} ..."
curl -fsSL "${XPI_URL}" -o "${TMPDIR}/dictionnaire_francais.xpi"

# Vérifier que le fichier a bien été récupéré
if [[ ! -s "${TMPDIR}/dictionnaire_francais.xpi" ]]; then
   echo "❌ Erreur : le fichier .xpi n'a pas pu être téléchargé."
   exit 1
fi

# ------------------------------------------------------------
# 3️⃣ Préparer le répertoire de politiques (si besoin)
# ---------------------------------------------------------

if [[ ! -d "${POLICIES_DIR}" ]]; then
    echo "📁 Création du répertoire de politiques : ${POLICIES_DIR}"
    mkdir -p "${POLICIES_DIR}"
fi

# ------------------------------------------
# 4️⃣ Construire le bloc JSON de la politique d'extension
# --------------------------------------------------------------

# Le format attendu par le Policy Engine :
# {
#   "policies": {
#     "Extensions": {
#       "Install": [
#     "file:///chemin/vers/extension.xpi"
#      ],
#       "Locked": [
#         "id@exemple.com"
#       ]
#    }
#   }
# }

# Copie du .xpi dans un emplacement accessible en lecture par tous les utilisateurs
GLOBAL_XPI_PATH="/usr/lib/firefox/distribution/${EXTENSION_ID}.xpi"
cp "${TMPDIR}/dictionnaire_francais.xpi" "${GLOBAL_XPI_PATH}"
chmod 644 "${GLOBAL_XPI_PATH}"

# Construction du JSON
read -r -d '' POLICY_CONTENT <<EOF
{
  "policies": {
    "Extensions": {
      "Install": [
        "file://${GLOBAL_XPI_PATH}"
      ],
      "Locked": [
        "${EXTENSION_ID}"
      ]
    }
  }
}
EOF

# --------------------------------------------------------------
# 5️⃣ Fusionner avec d’éventuelles politiques existantes
# -------------------------------------------------------

if [[ -f "${POLICIES_JSON}" ]]; then
    # Si un policies.json existe déjà, on le merge de façon prudente.
    # On utilise jq (installable via apt) pour éviter d’écraser d’autres règles.
    if ! command -v jq >/dev/null 2>&1; then
       echo "⚙️ jq n'est pas installé – installation rapide…"
        apt-get update && apt-get install -y jq
    fi

   echo "🔧 Fusion avec le policies.json existant…"
    tmp_merged="$(mktemp)"
    jq -s 'reduce .[] as $item ({}; . * $item)' "${POLICIES_JSON}" <(echo "${POLICY_CONTENT}") >"${tmp_merged}"
    mv "${tmp_merged}" "${POLICIES_JSON}"
else
   echo "📝 Création du fichier de politiques : ${POLICIES_JSON}"
    echo "${POLICY_CONTENT}" >"${POLICIES_JSON}"
fi

chmod 644 "${POLICIES_JSON}"

# ------------------------------------------
# 6️⃣ Vérification finale
# --------------------------------------------------------------

echo "✅ Installation terminée !"
echo "• Extension .xpi placée ici : ${GLOBAL_XPI_PATH}"
echo "• Politique enregistrée dans : ${POLICIES_JSON}"
echo ""
echo "Lorsque Firefox sera démarré pour la première fois (ou après un redémarrage),"
echo "le dictionnaire français sera automatiquement installé et verrouillé,"
echo "c’est‑à‑dire activé par défaut et non désinstallable par l’utilisateur."
echo "
echo "⚠️ Si vous avez déjà des profils Firefox ouverts, fermez‑les puis relancez le navigateur"
echo "    afin que la nouvelle politique soit prise en compte."

# Fin du script