@echo off
echo ====================================
echo  Résolution des conflits Git
echo ====================================
echo.

echo [INFO] Récupération des modifications distantes...
echo [INFO] Exécution de git pull avec l'option --rebase...

git pull --rebase origin main
if %ERRORLEVEL% neq 0 (
    echo [AVERTISSEMENT] Conflit détecté lors du pull rebase.
    echo.
    echo [INFO] Options disponibles:
    echo 1. Résoudre manuellement les conflits, puis exécuter:
    echo    git add .
    echo    git rebase --continue
    echo.
    echo 2. Ou forcer le push (ATTENTION: cela écrasera les modifications distantes):
    echo    git push -f origin main
    echo.
    echo 3. Ou annuler le rebase:
    echo    git rebase --abort
    echo.
    echo [CONSEIL] Si vous n'êtes pas sûr, choisissez l'option 3 et consultez un expert Git.
    pause
    exit /b 1
)

echo [SUCCÈS] Modifications distantes récupérées.
echo.

echo [INFO] Envoi des fichiers vers GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo [ERREUR] Échec de l'envoi des fichiers.
    echo.
    echo [INFO] Dernière tentative avec force push (ATTENTION: cela écrasera les modifications distantes)
    echo [INFO] Voulez-vous continuer avec force push? (O/N)
    set /p FORCE_PUSH="Votre choix: "
    if /i "%FORCE_PUSH%"=="O" (
        git push -f origin main
        if %ERRORLEVEL% neq 0 (
            echo [ERREUR] Échec du force push.
            exit /b %ERRORLEVEL%
        )
        echo [SUCCÈS] Force push réussi.
    ) else (
        echo [INFO] Force push annulé.
        exit /b 1
    )
) else (
    echo [SUCCÈS] Fichiers envoyés vers GitHub.
)

echo.
echo ====================================
echo  Conflit résolu, dépôt mis à jour !
echo ====================================
echo.
echo Votre projet est maintenant à jour sur GitHub et prêt pour être déployé sur Vercel.
echo.
echo Pour déployer sur Vercel, exécutez le script deploy-vercel-fix.bat
echo.
pause 