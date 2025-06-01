@echo off
echo ====================================
echo  Réinitialisation et synchronisation Git
echo ====================================
echo.

echo [ATTENTION] Ce script va réinitialiser votre dépôt Git local pour résoudre les conflits.
echo [ATTENTION] Toutes les modifications non poussées seront perdues.
echo.
echo Voulez-vous continuer? (O/N)
set /p CONTINUE="Votre choix: "

if /i not "%CONTINUE%"=="O" (
    echo Opération annulée.
    exit /b 0
)

echo.
echo [ÉTAPE 1] Sauvegarde des fichiers importants...
if not exist "backup" mkdir backup
xcopy "*.json" "backup\" /Y
xcopy ".env*" "backup\" /Y 2>nul
xcopy "README.md" "backup\" /Y 2>nul
echo [SUCCÈS] Sauvegarde effectuée dans le dossier 'backup'.
echo.

echo [ÉTAPE 2] Obtention de l'URL du dépôt distant...
for /f "tokens=*" %%a in ('git remote get-url origin 2^>nul') do set REPO_URL=%%a
if "%REPO_URL%"=="" (
    echo [ERREUR] Impossible de trouver l'URL du dépôt distant.
    echo Veuillez entrer l'URL de votre dépôt GitHub:
    set /p REPO_URL="URL du dépôt GitHub (ex: https://github.com/Amolyy25/convertisseur.git): "
    if "%REPO_URL%"=="" (
        echo [ERREUR] Aucune URL fournie. Opération annulée.
        exit /b 1
    )
)
echo [INFO] URL du dépôt: %REPO_URL%
echo.

echo [ÉTAPE 3] Suppression du dépôt Git local...
if exist ".git" (
    rmdir /S /Q .git
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Impossible de supprimer le dossier .git
        exit /b %ERRORLEVEL%
    )
)
echo [SUCCÈS] Dépôt Git local supprimé.
echo.

echo [ÉTAPE 4] Réinitialisation du dépôt Git...
git init
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'initialisation du dépôt Git.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Nouveau dépôt Git initialisé.
echo.

echo [ÉTAPE 5] Configuration du dépôt distant...
git remote add origin %REPO_URL%
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout du dépôt distant.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Dépôt distant configuré.
echo.

echo [ÉTAPE 6] Récupération du contenu distant...
git fetch origin
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] Échec de la récupération du contenu distant.
    echo [INFO] Continuons quand même...
)
echo [SUCCÈS] Contenu distant récupéré.
echo.

echo [ÉTAPE 7] Création d'une nouvelle branche main...
git checkout -b main
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la création de la branche main.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Branche main créée.
echo.

echo [ÉTAPE 8] Ajout des fichiers actuels...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés.
echo.

echo [ÉTAPE 9] Création d'un commit...
git commit -m "Réinitialisation et synchronisation du projet convertisseur"
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] Aucun fichier à commiter ou échec du commit.
    echo [INFO] Continuons quand même...
)
echo [SUCCÈS] Commit créé.
echo.

echo [ÉTAPE 10] Envoi des fichiers vers GitHub...
echo [INFO] Cette opération va écraser les modifications distantes. Continuer? (O/N)
set /p FORCE_PUSH="Votre choix: "

if /i not "%FORCE_PUSH%"=="O" (
    echo Opération annulée.
    exit /b 0
)

git push -f origin main
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'envoi des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers envoyés vers GitHub avec succès.
echo.

echo ====================================
echo  Réinitialisation terminée !
echo ====================================
echo.
echo Votre dépôt Git a été complètement réinitialisé et synchronisé avec GitHub.
echo Vous pouvez maintenant déployer sur Vercel en exécutant deploy-vercel-fix.bat
echo.
pause 