@echo off
echo ============================================
echo  Correction des fichiers volumineux GitHub
echo ============================================
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

echo [ÉTAPE 1] Mise à jour du fichier .gitignore...
echo [INFO] Vérification que les dossiers builds et node_modules sont bien ignorés...
findstr /c:"/builds" .gitignore >nul
if %ERRORLEVEL% neq 0 (
    echo [INFO] Ajout de /builds au fichier .gitignore...
    echo /builds/** >> .gitignore
    echo builds/ >> .gitignore
)
findstr /c:"/node_modules" .gitignore >nul
if %ERRORLEVEL% neq 0 (
    echo [INFO] Ajout de /node_modules au fichier .gitignore...
    echo /node_modules >> .gitignore
)
findstr /c:"/releases" .gitignore >nul
if %ERRORLEVEL% neq 0 (
    echo [INFO] Ajout de /releases au fichier .gitignore...
    echo /releases/** >> .gitignore
    echo releases/ >> .gitignore
)
echo [SUCCÈS] Fichier .gitignore mis à jour.
echo.

echo [ÉTAPE 2] Suppression des fichiers volumineux du suivi Git...
echo [INFO] Suppression des dossiers builds, node_modules et releases du suivi Git...
git rm -r --cached builds/ 2>nul
git rm -r --cached node_modules/ 2>nul
git rm -r --cached releases/ 2>nul
echo [SUCCÈS] Fichiers volumineux retirés du suivi Git.
echo.

echo [ÉTAPE 3] Création d'un nouveau commit pour appliquer le .gitignore...
git add .gitignore
git commit -m "Mise à jour du .gitignore pour exclure les fichiers volumineux"
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la création du commit.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Commit créé avec le nouveau .gitignore.
echo.

echo [ÉTAPE 4] Préparation des fichiers pour le push...
echo [INFO] Ajout des fichiers (en respectant le .gitignore)...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'ajout des fichiers.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Fichiers ajoutés au dépôt.
echo.

echo [ÉTAPE 5] Création d'un commit pour le déploiement...
git commit -m "Déploiement du convertisseur de fichiers (sans fichiers volumineux)"
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la création du commit.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Commit créé.
echo.

echo [ÉTAPE 6] Envoi des fichiers vers GitHub...
echo [INFO] Tentative avec l'option force pour remplacer l'historique problématique...
git push -f origin main
if %ERRORLEVEL% neq 0 (
    echo [INFO] Tentative avec la branche master...
    git push -f origin master
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de l'envoi des fichiers.
        echo.
        echo [INFO] Vérifiez que :
        echo - Vous avez les droits d'accès au dépôt
        echo - Le dépôt distant existe
        echo - Votre branche locale est bien 'main' ou 'master'
        exit /b %ERRORLEVEL%
    )
)
echo [SUCCÈS] Fichiers envoyés vers GitHub.
echo.

echo ================================================
echo  Correction des fichiers volumineux terminée !
echo ================================================
echo.
echo Votre dépôt a été nettoyé des fichiers volumineux.
echo Les dossiers builds, node_modules et releases sont maintenant ignorés.
echo.
echo Vous pouvez à présent déployer votre projet sur Vercel.
echo.
pause 