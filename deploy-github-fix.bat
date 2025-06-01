@echo off
echo ====================================
echo  Déploiement sur GitHub (Version corrigée)
echo ====================================
echo.

echo [INFO] Vérification de l'installation de Git...
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Git n'est pas installé ou n'est pas dans le PATH.
    echo Veuillez installer Git depuis https://git-scm.com/download/win
    exit /b 1
)
echo [SUCCÈS] Git est installé.
echo.

echo [ÉTAPE 1] Configuration du dépôt Git...
if not exist ".git" (
    echo [INFO] Initialisation d'un nouveau dépôt Git...
    git init
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'initialisation du dépôt Git.
        exit /b %ERRORLEVEL%
    )
) else (
    echo [INFO] Dépôt Git déjà initialisé.
)
echo.

echo [ÉTAPE 2] Préparation du projet pour Vercel...
echo [INFO] Vérification du fichier vercel.json...
if not exist "vercel.json" (
    echo [INFO] Création du fichier vercel.json...
    (
    echo {
    echo   "version": 2,
    echo   "builds": [
    echo     {
    echo       "src": "package.json",
    echo       "use": "@vercel/next"
    echo     }
    echo   ]
    echo }
    ) > vercel.json
    echo [SUCCÈS] Fichier vercel.json créé.
) else (
    echo [INFO] Le fichier vercel.json existe déjà.
)
echo.

echo [ÉTAPE 3] Création/Mise à jour du README.md...
echo [INFO] Création du fichier README.md...
echo # Convertisseur de Fichiers > README.md
echo. >> README.md
echo Application web permettant de convertir facilement des fichiers images et vidéos entre différents formats. >> README.md
echo. >> README.md
echo ## Fonctionnalités >> README.md
echo. >> README.md
echo - Conversion d'images (JPG, PNG, WEBP, GIF, etc.) >> README.md
echo - Conversion de vidéos (MP4, WEBM, MOV, AVI, etc.) >> README.md
echo - Interface utilisateur intuitive et responsive >> README.md
echo - Traitement côté client pour une confidentialité maximale >> README.md
echo - Mode sombre/clair >> README.md
echo. >> README.md
echo ## Technologies utilisées >> README.md
echo. >> README.md
echo - Next.js >> README.md
echo - React >> README.md
echo - TypeScript >> README.md
echo - Tailwind CSS >> README.md
echo - FFmpeg.wasm >> README.md
echo. >> README.md
echo ## Déploiement >> README.md
echo. >> README.md
echo Ce projet peut être déployé sur Vercel en un clic: >> README.md
echo. >> README.md
echo [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/Amolyy25/convertisseur) >> README.md
echo. >> README.md
echo ## Développé par >> README.md
echo. >> README.md
echo [Amaury Meiller](https://meillerweb.fr) >> README.md
echo [SUCCÈS] Fichier README.md créé.
echo.

echo [ÉTAPE 4] Création du fichier .gitignore...
if not exist ".gitignore" (
    echo [INFO] Création du fichier .gitignore...
    echo # dependencies > .gitignore
    echo /node_modules >> .gitignore
    echo /.pnp >> .gitignore
    echo .pnp.js >> .gitignore
    echo. >> .gitignore
    echo # testing >> .gitignore
    echo /coverage >> .gitignore
    echo. >> .gitignore
    echo # next.js >> .gitignore
    echo /.next/ >> .gitignore
    echo /out/ >> .gitignore
    echo. >> .gitignore
    echo # production >> .gitignore
    echo /build >> .gitignore
    echo. >> .gitignore
    echo # misc >> .gitignore
    echo .DS_Store >> .gitignore
    echo *.pem >> .gitignore
    echo. >> .gitignore
    echo # debug >> .gitignore
    echo npm-debug.log* >> .gitignore
    echo yarn-debug.log* >> .gitignore
    echo yarn-error.log* >> .gitignore
    echo. >> .gitignore
    echo # local env files >> .gitignore
    echo .env*.local >> .gitignore
    echo. >> .gitignore
    echo # builds >> .gitignore
    echo /builds >> .gitignore
    echo /releases >> .gitignore
    echo [SUCCÈS] Fichier .gitignore créé.
) else (
    echo [INFO] Le fichier .gitignore existe déjà.
)
echo.

echo [ÉTAPE 5] Ajout des fichiers au dépôt...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés au dépôt.
echo.

echo [ÉTAPE 6] Création d'un commit...
git commit -m "Déploiement du convertisseur de fichiers pour Vercel"
if %ERRORLEVEL% neq 0 (
    echo [INFO] Aucun changement détecté ou échec du commit.
    echo [INFO] Continuons quand même...
)
echo [SUCCÈS] Commit créé.
echo.

echo [ÉTAPE 7] Configuration du dépôt distant GitHub...
git remote -v | findstr "origin" >nul
if %ERRORLEVEL% neq 0 (
    echo [INFO] Veuillez entrer l'URL de votre dépôt GitHub:
    set /p GITHUB_URL="URL du dépôt GitHub (ex: https://github.com/Amolyy25/convertisseur.git): "
    git remote add origin %GITHUB_URL%
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'ajout du dépôt distant.
        exit /b %ERRORLEVEL%
    )
) else (
    echo [INFO] Dépôt distant déjà configuré.
)
echo.

echo [ÉTAPE 8] Configuration de la branche principale...
echo [INFO] Configuration de la branche 'main'...
git branch -M main
echo.

echo [ÉTAPE 9] Envoi des fichiers vers GitHub...
echo [INFO] Cette étape peut vous demander de saisir vos identifiants GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'envoi des fichiers.
    echo.
    echo [INFO] Vérifiez que :
    echo - Vous avez les droits d'accès au dépôt
    echo - Le dépôt distant existe
    echo - Vos identifiants GitHub sont corrects
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers envoyés vers GitHub.
echo.

echo ====================================
echo  Déploiement sur GitHub terminé !
echo ====================================
echo.
echo Votre projet est maintenant sur GitHub et prêt pour être déployé sur Vercel.
echo.
echo Pour déployer sur Vercel:
echo 1. Allez sur https://vercel.com/new
echo 2. Importez votre dépôt GitHub (https://github.com/Amolyy25/convertisseur)
echo 3. Suivez les instructions de Vercel
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 