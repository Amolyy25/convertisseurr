#!/bin/bash

echo "===================================="
echo " Build du Convertisseur de Fichiers"
echo "===================================="
echo ""

# Définir la date et l'heure pour le nom du dossier de build
DATESTAMP=$(date +"%Y-%m-%d")
TIMESTAMP=$(date +"%H-%M-%S")
FULLSTAMP="${DATESTAMP}_${TIMESTAMP}"

BUILD_FOLDER="builds/build_${FULLSTAMP}"

echo "[INFO] Date et heure actuelles: $DATESTAMP $TIMESTAMP"
echo "[INFO] Dossier de build: $BUILD_FOLDER"
echo ""

echo "[ÉTAPE 1] Installation des dépendances..."
npm install
if [ $? -ne 0 ]; then
    echo "[ERREUR] Échec de l'installation des dépendances."
    exit 1
fi
echo "[SUCCÈS] Dépendances installées."
echo ""

echo "[ÉTAPE 2] Génération du build..."
npm run build
if [ $? -ne 0 ]; then
    echo "[ERREUR] Échec de la génération du build."
    exit 1
fi
echo "[SUCCÈS] Build généré avec succès."
echo ""

echo "[ÉTAPE 3] Création du dossier de destination..."
mkdir -p "$BUILD_FOLDER"
echo "[SUCCÈS] Dossier de destination créé."
echo ""

echo "[ÉTAPE 4] Copie des fichiers du build..."
cp -R .next "$BUILD_FOLDER/"
cp package.json "$BUILD_FOLDER/"
cp next.config.js "$BUILD_FOLDER/"
if [ -d "public" ]; then
    cp -R public "$BUILD_FOLDER/"
fi

echo "[INFO] Création du fichier de démarrage..."
cat > "$BUILD_FOLDER/start.sh" << 'EOL'
#!/bin/bash
echo "Démarrage du Convertisseur de Fichiers..."
npm install
npm start
EOL
chmod +x "$BUILD_FOLDER/start.sh"

echo "[SUCCÈS] Fichiers copiés avec succès."
echo ""

echo "===================================="
echo " Build terminé avec succès !"
echo "===================================="
echo ""
echo "Le build se trouve dans le dossier: $BUILD_FOLDER"
echo "Pour exécuter l'application:"
echo "1. Naviguez vers le dossier $BUILD_FOLDER"
echo "2. Exécutez ./start.sh"
echo ""
echo "Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller."
echo "" 