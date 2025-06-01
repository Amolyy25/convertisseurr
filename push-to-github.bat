@echo off
echo ====================================
echo  Envoi des modifications sur GitHub
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

echo [ÉTAPE 1] Vérification du dépôt Git...
if not exist ".git" (
    echo [ERREUR] Aucun dépôt Git trouvé dans ce répertoire.
    echo Exécutez d'abord le script "deploy-to-github.bat" pour initialiser le dépôt.
    exit /b 1
)
echo [SUCCÈS] Dépôt Git trouvé.
echo.

echo [ÉTAPE 2] Vérification du dépôt distant...
git remote -v | findstr "origin" >nul
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Aucun dépôt distant "origin" configuré.
    echo Exécutez d'abord le script "deploy-to-github.bat" pour configurer le dépôt distant.
    exit /b 1
)
echo [SUCCÈS] Dépôt distant configuré.
echo.

echo [ÉTAPE 3] Ajout des fichiers modifiés...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés.
echo.

echo [ÉTAPE 4] Création d'un commit...
set /p COMMIT_MSG="Message du commit (ex: Mise à jour de l'interface): "
if "%COMMIT_MSG%"=="" set COMMIT_MSG="Mise à jour du convertisseur de fichiers"
git commit -m "%COMMIT_MSG%"
if %ERRORLEVEL% neq 0 (
    echo [INFO] Aucun changement détecté ou échec du commit.
    echo [INFO] Si vous avez modifié des fichiers, vérifiez qu'ils ne sont pas ignorés par .gitignore.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Commit créé.
echo.

echo [ÉTAPE 5] Envoi des modifications vers GitHub...
git push
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'envoi des modifications.
    echo [INFO] Vérifiez vos identifiants GitHub ou la connexion internet.
    echo [INFO] Vous pouvez aussi essayer: git push -u origin main
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Modifications envoyées vers GitHub.
echo.

echo ====================================
echo  Envoi sur GitHub terminé !
echo ====================================
echo.
echo Votre projet est maintenant à jour sur GitHub.
echo Pour déployer sur Vercel, vous pouvez utiliser le script "deploy-to-vercel.bat"
echo ou déclencher un nouveau déploiement depuis le tableau de bord Vercel.
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 