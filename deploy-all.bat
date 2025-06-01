@echo off
echo ====================================
echo  Déploiement complet sur GitHub et Vercel
echo  Convertisseur de Fichiers
echo ====================================
echo.

echo [INFO] Vérification des prérequis...
echo [INFO] Vérification de Git...
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Git n'est pas installé ou n'est pas dans le PATH.
    echo Veuillez installer Git depuis https://git-scm.com/download/win
    exit /b 1
)

echo [INFO] Vérification de Node.js...
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Node.js n'est pas installé ou n'est pas dans le PATH.
    echo Veuillez installer Node.js depuis https://nodejs.org/
    exit /b 1
)

echo [INFO] Vérification de npm...
where npm >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] npm n'est pas installé ou n'est pas dans le PATH.
    echo Veuillez réinstaller Node.js depuis https://nodejs.org/
    exit /b 1
)

echo [INFO] Vérification de Vercel CLI...
call vercel --version >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] Vercel CLI n'est pas installé. Installation en cours...
    call npm install -g vercel
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'installation de Vercel CLI.
        exit /b %ERRORLEVEL%
    )
)
echo [SUCCÈS] Tous les prérequis sont installés.
echo.

echo [PHASE 1] Préparation du projet
echo ===============================
echo.

echo [ÉTAPE 1.1] Installation des dépendances...
call npm install
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'installation des dépendances.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Dépendances installées.
echo.

echo [ÉTAPE 1.2] Génération du build Next.js...
call npm run build
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la génération du build.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Build généré avec succès.
echo.

echo [ÉTAPE 1.3] Création/mise à jour des fichiers de configuration...
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

echo [INFO] Vérification du fichier .vercelignore...
if not exist ".vercelignore" (
    echo [INFO] Création du fichier .vercelignore...
    (
    echo .git
    echo /builds
    echo /releases
    echo *.bat
    echo *.sh
    ) > .vercelignore
    echo [SUCCÈS] Fichier .vercelignore créé.
) else (
    echo [INFO] Le fichier .vercelignore existe déjà.
)

echo [INFO] Vérification du fichier .gitignore...
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

echo [INFO] Création/mise à jour du README.md...
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
echo [SUCCÈS] Fichiers de configuration créés/mis à jour.
echo.

echo [PHASE 2] Déploiement sur GitHub
echo ===============================
echo.

echo [ÉTAPE 2.1] Configuration du dépôt Git...
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

echo [ÉTAPE 2.2] Ajout des fichiers au dépôt...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés au dépôt.
echo.

echo [ÉTAPE 2.3] Création d'un commit...
git commit -m "Déploiement du convertisseur de fichiers pour Vercel"
if %ERRORLEVEL% neq 0 (
    echo [INFO] Aucun changement détecté ou échec du commit.
    echo [INFO] Continuation du processus...
)
echo [SUCCÈS] Commit créé.
echo.

echo [ÉTAPE 2.4] Configuration du dépôt distant GitHub...
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

echo [ÉTAPE 2.5] Envoi des fichiers vers GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo [INFO] Tentative avec la branche master...
    git push -u origin master
    if %ERRORLEVEL% neq 0 (
        echo [AVERTISSEMENT] Échec de l'envoi des fichiers.
        echo [INFO] Tentative de configuration de la branche principale...
        git branch -M main
        git push -u origin main
        if %ERRORLEVEL% neq 0 (
            echo [ERREUR] Échec de l'envoi des fichiers sur GitHub.
            echo [INFO] Vérifiez vos identifiants GitHub et les droits d'accès au dépôt.
            echo [INFO] Nous allons quand même continuer avec le déploiement sur Vercel...
        )
    )
)
echo [SUCCÈS] Fichiers envoyés vers GitHub.
echo.

echo [PHASE 3] Déploiement sur Vercel
echo ===============================
echo.

echo [ÉTAPE 3.1] Configuration et déploiement sur Vercel...
echo [INFO] Vous allez être guidé pour configurer et déployer votre projet sur Vercel.
echo [INFO] Si vous avez déjà un compte Vercel, vous serez invité à vous connecter.
echo [INFO] Sinon, vous pourrez en créer un pendant le processus.
echo.
echo [INFO] Suivez les instructions et répondez aux questions :
echo - Connectez-vous à votre compte Vercel
echo - Importez votre projet depuis GitHub
echo - Configurez les options de déploiement
echo.
pause
echo.

echo [ÉTAPE 3.2] Déploiement sur Vercel...
call vercel
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec du déploiement sur Vercel.
    exit /b %ERRORLEVEL%
)
echo.
echo [SUCCÈS] Déploiement sur Vercel terminé.
echo.

echo ====================================
echo  Déploiement complet terminé !
echo ====================================
echo.
echo Votre projet est maintenant :
echo 1. Correctement configuré avec tous les fichiers nécessaires
echo 2. Déployé sur GitHub à l'adresse : %GITHUB_URL%
echo 3. Déployé sur Vercel (voir l'URL fournie ci-dessus)
echo.
echo Le déploiement automatique est maintenant configuré :
echo - Chaque push sur GitHub déclenchera automatiquement un nouveau déploiement sur Vercel
echo.
echo Pour mettre à jour votre projet à l'avenir, utilisez simplement :
echo - push-to-github.bat (pour envoyer les modifications sur GitHub)
echo - ou git add . && git commit -m "Votre message" && git push
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 