@echo off
echo =================================================
echo  Configuration et déploiement du Convertisseur
echo =================================================
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

echo [ÉTAPE 1] Création/Mise à jour du fichier .gitignore...
echo # See https://help.github.com/articles/ignoring-files/ for more about ignoring files. > .gitignore
echo. >> .gitignore
echo # dependencies >> .gitignore
echo /node_modules >> .gitignore
echo /.pnp >> .gitignore
echo .pnp.* >> .gitignore
echo .yarn/* >> .gitignore
echo !.yarn/patches >> .gitignore
echo !.yarn/plugins >> .gitignore
echo !.yarn/releases >> .gitignore
echo !.yarn/versions >> .gitignore
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
echo /builds >> .gitignore
echo /builds/** >> .gitignore
echo builds/ >> .gitignore
echo. >> .gitignore
echo # releases >> .gitignore
echo /releases >> .gitignore
echo /releases/** >> .gitignore
echo releases/ >> .gitignore
echo. >> .gitignore
echo # misc >> .gitignore
echo .DS_Store >> .gitignore
echo *.pem >> .gitignore
echo. >> .gitignore
echo # debug >> .gitignore
echo npm-debug.log* >> .gitignore
echo yarn-debug.log* >> .gitignore
echo yarn-error.log* >> .gitignore
echo .pnpm-debug.log* >> .gitignore
echo. >> .gitignore
echo # env files >> .gitignore
echo .env* >> .gitignore
echo. >> .gitignore
echo # vercel >> .gitignore
echo .vercel >> .gitignore
echo. >> .gitignore
echo # typescript >> .gitignore
echo *.tsbuildinfo >> .gitignore
echo next-env.d.ts >> .gitignore
echo [SUCCÈS] Fichier .gitignore créé/mis à jour.
echo.

echo [ÉTAPE 2] Création/Mise à jour du fichier vercel.json...
echo { > vercel.json
echo   "version": 2, >> vercel.json
echo   "builds": [ >> vercel.json
echo     { >> vercel.json
echo       "src": "package.json", >> vercel.json
echo       "use": "@vercel/next" >> vercel.json
echo     } >> vercel.json
echo   ] >> vercel.json
echo } >> vercel.json
echo [SUCCÈS] Fichier vercel.json créé/mis à jour.
echo.

echo [ÉTAPE 3] Mise à jour du README.md...
echo # Convertisseur de Fichiers > README.md
echo. >> README.md
echo Application web permettant de convertir facilement des fichiers images et vidéos entre différents formats. >> README.md
echo. >> README.md
echo ## Fonctionnalités >> README.md
echo. >> README.md
echo - Conversion d'images ^(JPG, PNG, WEBP, GIF, etc.^) >> README.md
echo - Conversion de vidéos ^(MP4, WEBM, MOV, AVI, etc.^) >> README.md
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
echo ## Développé par >> README.md
echo. >> README.md
echo [Amaury Meiller](https://meillerweb.fr) >> README.md
echo [SUCCÈS] Fichier README.md créé/mis à jour.
echo.

echo [ÉTAPE 4] Nettoyage du dépôt Git existant (si présent)...
if exist ".git" (
    echo [INFO] Suppression du dépôt Git existant...
    rmdir /s /q .git
    echo [SUCCÈS] Ancien dépôt Git supprimé.
) else (
    echo [INFO] Aucun dépôt Git existant trouvé.
)
echo.

echo [ÉTAPE 5] Initialisation d'un nouveau dépôt Git...
git init
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'initialisation du dépôt Git.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Nouveau dépôt Git initialisé.
echo.

echo [ÉTAPE 6] Ajout des fichiers au dépôt...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés au dépôt.
echo.

echo [ÉTAPE 7] Création du commit initial...
git commit -m "Premier commit du convertisseur de fichiers"
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la création du commit.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Commit initial créé.
echo.

echo [ÉTAPE 8] Configuration d'un nouveau dépôt GitHub...
echo [INFO] Veuillez créer un nouveau dépôt sur GitHub (sans README, .gitignore ou licence)
echo [INFO] puis entrez l'URL du nouveau dépôt:
set /p GITHUB_URL="URL du nouveau dépôt GitHub (ex: https://github.com/username/convertisseur.git): "
git remote add origin %GITHUB_URL%
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout du dépôt distant.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Dépôt distant ajouté.
echo.

echo [ÉTAPE 9] Envoi des fichiers vers GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo [INFO] La branche principale n'est peut-être pas 'main'. Tentative avec 'master'...
    git branch -M main
    git push -u origin main
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'envoi des fichiers.
        exit /b %ERRORLEVEL%
    )
)
echo [SUCCÈS] Fichiers envoyés vers GitHub.
echo.

echo [ÉTAPE 10] Déploiement sur Vercel...
echo [INFO] Pour déployer sur Vercel, vous avez deux options:
echo.
echo Option 1: Déploiement manuel
echo  1. Allez sur https://vercel.com/new
echo  2. Importez votre nouveau dépôt GitHub
echo  3. Configurez selon vos préférences et cliquez sur "Deploy"
echo.
echo Option 2: Déploiement via Vercel CLI
echo  1. Installez Vercel CLI avec 'npm i -g vercel'
echo  2. Exécutez 'vercel' dans ce répertoire
echo  3. Suivez les instructions à l'écran
echo.

echo [QUESTION] Souhaitez-vous installer Vercel CLI et déployer maintenant? (O/N)
set /p INSTALL_VERCEL="Votre choix: "
if /i "%INSTALL_VERCEL%"=="O" (
    echo [INFO] Installation de Vercel CLI...
    npm i -g vercel
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'installation de Vercel CLI.
        echo [INFO] Vous pouvez toujours déployer manuellement via l'interface web de Vercel.
    ) else (
        echo [SUCCÈS] Vercel CLI installé.
        echo [INFO] Déploiement sur Vercel...
        vercel --prod
    )
) else (
    echo [INFO] Vous avez choisi de ne pas utiliser Vercel CLI.
    echo [INFO] Veuillez déployer manuellement via l'interface web de Vercel.
)
echo.

echo [ÉTAPE 11] Nettoyage des anciens scripts...
echo [INFO] Suppression des scripts obsolètes...
if exist "fix-github-large-files.bat" del /f fix-github-large-files.bat
if exist "deploy-to-github.bat" del /f deploy-to-github.bat
if exist "deploy-to-vercel.bat" del /f deploy-to-vercel.bat
if exist "build-project.bat" del /f build-project.bat
if exist "create-release.bat" del /f create-release.bat
if exist "deploy-all.bat" del /f deploy-all.bat
if exist "deploy-github-fix.bat" del /f deploy-github-fix.bat
if exist "deploy-vercel-fix.bat" del /f deploy-vercel-fix.bat
if exist "fix-github-conflict.bat" del /f fix-github-conflict.bat
if exist "push-to-github.bat" del /f push-to-github.bat
if exist "reset-and-push.bat" del /f reset-and-push.bat
if exist "setup-vercel.bat" del /f setup-vercel.bat
echo [SUCCÈS] Scripts obsolètes supprimés.
echo.

echo =================================================
echo  Configuration et déploiement terminés !
echo =================================================
echo.
echo Votre projet a été configuré et déployé avec succès.
echo.
echo Résumé des actions effectuées:
echo - Création/mise à jour de .gitignore, vercel.json et README.md
echo - Initialisation d'un nouveau dépôt Git
echo - Création et push du commit initial vers GitHub
echo - Instructions pour le déploiement sur Vercel
echo - Nettoyage des scripts obsolètes
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 