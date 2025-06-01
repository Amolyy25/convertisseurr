@echo off
echo ====================================
echo  Déploiement sur Vercel (Version corrigée)
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

echo [ÉTAPE 1] Préparation pour Vercel...
echo [INFO] Vérification du fichier .vercelignore...
if not exist ".vercelignore" (
    echo [INFO] Création du fichier .vercelignore...
    echo .git > .vercelignore
    echo /builds >> .vercelignore
    echo /releases >> .vercelignore
    echo *.bat >> .vercelignore
    echo *.sh >> .vercelignore
    echo [SUCCÈS] Fichier .vercelignore créé.
) else (
    echo [INFO] Le fichier .vercelignore existe déjà.
)
echo.

echo [ÉTAPE 2] Déploiement sur Vercel...
echo [INFO] Vous allez être guidé pour vous connecter à Vercel et déployer votre projet.
echo [INFO] Si c'est la première fois, suivez les instructions pour vous connecter.
echo.
echo [INFO] Options recommandées lors du déploiement:
echo - Sélectionnez le répertoire actuel pour déployer (appuyez simplement sur Entrée)
echo - Répondez "y" pour lier à un projet existant si vous l'avez déjà configuré sur Vercel
echo - Choisissez votre équipe/compte
echo - Confirmez le nom du projet ou fournissez-en un nouveau
echo - Conservez le répertoire racine par défaut (appuyez simplement sur Entrée)
echo.
pause
echo.

echo [ÉTAPE 3] Lancement du déploiement...
call vercel
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec du déploiement sur Vercel.
    exit /b %ERRORLEVEL%
)
echo.
echo [SUCCÈS] Déploiement sur Vercel terminé.
echo.

echo ====================================
echo  Déploiement sur Vercel terminé !
echo ====================================
echo.
echo Votre application est maintenant déployée sur Vercel.
echo Vous pouvez y accéder via l'URL fournie ci-dessus.
echo.
echo Pour configurer un déploiement automatique à chaque push sur GitHub:
echo 1. Connectez-vous à votre compte Vercel (https://vercel.com)
echo 2. Accédez à votre projet
echo 3. Allez dans "Settings" > "Git"
echo 4. Connectez votre compte GitHub et sélectionnez votre dépôt
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 