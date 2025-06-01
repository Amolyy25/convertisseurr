@echo off
echo ====================================
echo  Création d'une Release
echo  Convertisseur de Fichiers
echo ====================================
echo.

rem Définir la date et l'heure pour le nom du dossier de build
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%-%MM%-%DD%"
set "timestamp=%HH%-%Min%-%Sec%"
set "fullstamp=%datestamp%_%timestamp%"

set "BUILD_FOLDER=builds\build_%fullstamp%"
set "RELEASE_NAME=convertisseur-fichiers-v1.0.0-%datestamp%"
set "RELEASE_FOLDER=releases\%RELEASE_NAME%"
set "RELEASE_ZIP=%RELEASE_NAME%.zip"

echo [INFO] Date et heure actuelles: %datestamp% %timestamp%
echo [INFO] Dossier de build: %BUILD_FOLDER%
echo [INFO] Nom de la release: %RELEASE_NAME%
echo.

echo [ÉTAPE 1] Installation des dépendances...
call npm install
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'installation des dépendances.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Dépendances installées.
echo.

echo [ÉTAPE 2] Génération du build...
call npm run build
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de la génération du build.
    exit /b %ERRORLEVEL%
)
echo [SUCCÈS] Build généré avec succès.
echo.

echo [ÉTAPE 3] Création des dossiers de destination...
if not exist "builds" mkdir builds
if not exist "%BUILD_FOLDER%" mkdir "%BUILD_FOLDER%"
if not exist "releases" mkdir releases
if not exist "%RELEASE_FOLDER%" mkdir "%RELEASE_FOLDER%"
echo [SUCCÈS] Dossiers de destination créés.
echo.

echo [ÉTAPE 4] Copie des fichiers du build...
xcopy ".next" "%BUILD_FOLDER%\.next" /E /I /H /Y
copy "package.json" "%BUILD_FOLDER%\"
copy "next.config.js" "%BUILD_FOLDER%\"
if exist "public" xcopy "public" "%BUILD_FOLDER%\public" /E /I /H /Y

echo [INFO] Création du fichier de démarrage...
(
echo @echo off
echo echo Démarrage du Convertisseur de Fichiers...
echo call npm install
echo call npm start
echo pause
) > "%BUILD_FOLDER%\start.bat"

echo [SUCCÈS] Fichiers copiés avec succès dans le dossier de build.
echo.

echo [ÉTAPE 5] Préparation de la release...
xcopy "%BUILD_FOLDER%" "%RELEASE_FOLDER%" /E /I /H /Y
copy "README.md" "%RELEASE_FOLDER%\" 2>nul
echo.

echo [ÉTAPE 6] Création du README pour la release...
(
echo # Convertisseur de Fichiers
echo.
echo Version: 1.0.0
echo Date: %datestamp%
echo.
echo ## Description
echo.
echo Application web permettant de convertir des fichiers images et vidéos entre différents formats.
echo.
echo ## Installation
echo.
echo 1. Assurez-vous d'avoir Node.js installé ^(version 14.x ou supérieure^)
echo 2. Exécutez le fichier `start.bat` pour installer les dépendances et démarrer l'application
echo 3. Ouvrez votre navigateur à l'adresse http://localhost:3000
echo.
echo ## Développé par
echo.
echo Amaury Meiller - [meillerweb.fr](https://meillerweb.fr)
echo.
) > "%RELEASE_FOLDER%\README.md"

echo [SUCCÈS] Release préparée avec succès.
echo.

echo [ÉTAPE 7] Création de l'archive ZIP...
echo [INFO] Vérification de la présence de PowerShell...
where powershell >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] PowerShell n'est pas disponible. L'archive ZIP ne sera pas créée.
) else (
    echo [INFO] Utilisation de PowerShell pour créer l'archive ZIP...
    powershell -Command "Compress-Archive -Path '%RELEASE_FOLDER%\*' -DestinationPath 'releases\%RELEASE_ZIP%' -Force"
    if %ERRORLEVEL% neq 0 (
        echo [ERREUR] Échec de la création de l'archive ZIP.
    ) else (
        echo [SUCCÈS] Archive ZIP créée avec succès: releases\%RELEASE_ZIP%
    )
)
echo.

echo ====================================
echo  Release créée avec succès !
echo ====================================
echo.
echo Informations:
echo - Dossier de build: %BUILD_FOLDER%
echo - Dossier de release: %RELEASE_FOLDER%
echo - Archive ZIP: releases\%RELEASE_ZIP% (si PowerShell est disponible)
echo.
echo Pour exécuter l'application à partir de la release:
echo 1. Naviguez vers le dossier %RELEASE_FOLDER%
echo 2. Exécutez start.bat
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 