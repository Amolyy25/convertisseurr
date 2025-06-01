@echo off
echo ====================================
echo  Build du Convertisseur de Fichiers
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

echo [INFO] Date et heure actuelles: %datestamp% %timestamp%
echo [INFO] Dossier de build: %BUILD_FOLDER%
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

echo [ÉTAPE 3] Création du dossier de destination...
if not exist "builds" mkdir builds
if not exist "%BUILD_FOLDER%" mkdir "%BUILD_FOLDER%"
echo [SUCCÈS] Dossier de destination créé.
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

echo [SUCCÈS] Fichiers copiés avec succès.
echo.

echo ====================================
echo  Build terminé avec succès !
echo ====================================
echo.
echo Le build se trouve dans le dossier: %BUILD_FOLDER%
echo Pour exécuter l'application:
echo 1. Naviguez vers le dossier %BUILD_FOLDER%
echo 2. Exécutez start.bat
echo.
echo Merci d'utiliser le Convertisseur de Fichiers d'Amaury Meiller.
echo.
pause 