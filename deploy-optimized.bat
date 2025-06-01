@echo off
echo =================================================
echo  Déploiement optimisé du Convertisseur
echo =================================================
echo.

echo [INFO] Préparation du dépôt Git...
if exist ".git" (
    echo [INFO] Un dépôt Git existe déjà, mise à jour...
) else (
    echo [INFO] Initialisation d'un nouveau dépôt Git...
    git init
)

echo [INFO] Mise à jour du .gitignore...
echo # See https://help.github.com/articles/ignoring-files/ > .gitignore
echo /node_modules >> .gitignore
echo /.next/ >> .gitignore
echo /out/ >> .gitignore
echo /build >> .gitignore
echo /builds >> .gitignore
echo /builds/** >> .gitignore
echo /releases >> .gitignore
echo /releases/** >> .gitignore
echo .DS_Store >> .gitignore
echo *.pem >> .gitignore
echo npm-debug.log* >> .gitignore
echo yarn-debug.log* >> .gitignore
echo yarn-error.log* >> .gitignore
echo .env* >> .gitignore
echo .vercel >> .gitignore
echo *.tsbuildinfo >> .gitignore
echo next-env.d.ts >> .gitignore

echo [INFO] Ajout des fichiers...
git add .

echo [INFO] Création d'un commit...
git commit -m "Mise à jour du convertisseur de fichiers"

echo [INFO] Configuration du dépôt distant...
echo [INFO] Voulez-vous utiliser le dépôt GitHub existant ou en configurer un nouveau?
echo 1. Utiliser le dépôt existant (si configuré)
echo 2. Configurer un nouveau dépôt
set /p REPO_CHOICE="Votre choix (1/2): "

if "%REPO_CHOICE%"=="2" (
    echo [INFO] Entrez l'URL du nouveau dépôt GitHub:
    set /p GITHUB_URL="URL (ex: https://github.com/username/convertisseur.git): "
    git remote remove origin 2>nul
    git remote add origin %GITHUB_URL%
)

echo [INFO] Préparation du push...
git branch -M main

echo [INFO] Envoi vers GitHub...
git push -u origin main

echo [INFO] Déploiement sur Vercel...
echo [INFO] Options de déploiement:
echo 1. Interface web Vercel (recommandé)
echo 2. CLI Vercel (installation nécessaire)
set /p VERCEL_CHOICE="Votre choix (1/2): "

if "%VERCEL_CHOICE%"=="1" (
    echo [INFO] Pour déployer via l'interface web:
    echo 1. Allez sur https://vercel.com/new
    echo 2. Importez votre dépôt GitHub
    echo 3. Suivez les instructions pour finaliser le déploiement
) else (
    echo [INFO] Installation et déploiement via Vercel CLI...
    npm i -g vercel
    vercel --prod
)

echo =================================================
echo  Déploiement terminé !
echo =================================================
echo.
pause 