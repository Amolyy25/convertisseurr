@echo off
echo ====================================
echo  Déploiement sur Vercel
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

echo [ÉTAPE 1] Installation des dépendances...
call npm install
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'installation des dépendances.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Dépendances installées.
echo.

echo [ÉTAPE 2] Déploiement sur Vercel...
echo [INFO] Suivez les instructions pour vous connecter à votre compte Vercel...
echo.
call vercel
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec du déploiement sur Vercel.
    exit /b %ERRORLEVEL%
)
echo.
echo [SUCCÈS] Déploiement sur Vercel effectué avec succès.
echo.

echo ====================================
echo  Déploiement terminé !
echo ====================================
echo.
echo Vous pouvez maintenant accéder à votre application sur l'URL fournie par Vercel.
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 