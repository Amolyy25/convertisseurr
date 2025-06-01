@echo off
echo ====================================
echo  Déploiement sur GitHub pour Vercel
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
if not exist "README.md" (
    echo [INFO] Création du fichier README.md...
    (
    echo # Convertisseur de Fichiers
    echo.
    echo Application web permettant de convertir facilement des fichiers images et vidéos entre différents formats.
    echo.
    echo ## Fonctionnalités
    echo.
    echo - Conversion d'images ^(JPG, PNG, WEBP, GIF, etc.^)
    echo - Conversion de vidéos ^(MP4, WEBM, MOV, AVI, etc.^)
    echo - Interface utilisateur intuitive et responsive
    echo - Traitement côté client pour une confidentialité maximale
    echo - Mode sombre/clair
    echo.
    echo ## Technologies utilisées
    echo.
    echo - Next.js
    echo - React
    echo - TypeScript
    echo - Tailwind CSS
    echo - FFmpeg.wasm
    echo.
    echo ## Déploiement
    echo.
    echo Ce projet peut être déployé sur Vercel en un clic:
    echo.
    echo [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/Amolyy25/convertisseur)
    echo.
    echo ## Développé par
    echo.
    echo [Amaury Meiller](https://meillerweb.fr)
    ) > README.md
    echo [SUCCÈS] Fichier README.md créé.
) else (
    echo [INFO] Le fichier README.md existe déjà.
)
echo.

echo [ÉTAPE 4] Création du fichier .gitignore...
if not exist ".gitignore" (
    echo [INFO] Création du fichier .gitignore...
    (
    echo # dependencies
    echo /node_modules
    echo /.pnp
    echo .pnp.js
    echo.
    echo # testing
    echo /coverage
    echo.
    echo # next.js
    echo /.next/
    echo /out/
    echo.
    echo # production
    echo /build
    echo.
    echo # misc
    echo .DS_Store
    echo *.pem
    echo.
    echo # debug
    echo npm-debug.log*
    echo yarn-debug.log*
    echo yarn-error.log*
    echo.
    echo # local env files
    echo .env*.local
    echo.
    echo # builds
    echo /builds
    echo /releases
    ) > .gitignore
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
    echo [ERREUR] Échec de la création du commit.
    exit /b %ERRORLEVEL%
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

echo [ÉTAPE 8] Envoi des fichiers vers GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo [INFO] Tentative avec la branche master...
    git push -u origin master
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'envoi des fichiers.
        echo.
        echo [INFO] Vérifiez que :
        echo - Vous avez les droits d'accès au dépôt
        echo - Le dépôt distant existe
        echo - Votre branche locale est bien 'main' ou 'master'
        echo.
        echo [INFO] Si la branche est différente, utilisez la commande:
        echo git branch -M main
        echo puis relancez ce script.
        exit /b %ERRORLEVEL%
    )
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
echo 2. Importez votre dépôt GitHub
echo 3. Suivez les instructions de Vercel
echo.
echo Vous pouvez également utiliser le script "deploy-to-vercel.bat"
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 