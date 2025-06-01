@echo off
echo ====================================
echo  Configuration de Vercel avec GitHub
echo ====================================
echo.

echo [INFO] Vérification de l'installation de Vercel CLI...
call vercel --version > nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] Vercel CLI n'est pas installé. Installation en cours...
    call npm install -g vercel
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'installation de Vercel CLI.
        exit /b %ERRORLEVEL%
    )
)
echo [SUCCÈS] Vercel CLI est installé.
echo.

echo [ÉTAPE 1] Préparation des fichiers de configuration pour Vercel...
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
echo.

echo [ÉTAPE 2] Configuration du projet Vercel...
echo [INFO] Vous allez être guidé pour configurer votre projet Vercel.
echo [INFO] Si vous avez déjà un compte Vercel, vous serez invité à vous connecter.
echo [INFO] Sinon, vous pourrez en créer un pendant le processus.
echo.
echo [INFO] Suivez les instructions et répondez aux questions :
echo - Sélectionnez l'option pour vous connecter à GitHub
echo - Choisissez votre dépôt GitHub
echo - Configurez les options de votre projet
echo.
pause
echo.

echo [ÉTAPE 3] Liaison avec GitHub et déploiement...
call vercel
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la configuration de Vercel.
    exit /b %ERRORLEVEL%
)
echo.
echo [SUCCÈS] Configuration de Vercel terminée.
echo.

echo ====================================
echo  Configuration Vercel terminée !
echo ====================================
echo.
echo Votre projet est maintenant configuré pour être déployé automatiquement 
echo sur Vercel à chaque push sur GitHub.
echo.
echo Recommandations :
echo 1. Visitez le tableau de bord Vercel pour vérifier le déploiement
echo 2. Configurez un domaine personnalisé si nécessaire
echo 3. Vérifiez les paramètres d'environnement dans le tableau de bord Vercel
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 