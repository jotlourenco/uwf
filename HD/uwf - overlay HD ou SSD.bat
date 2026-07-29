:: =========================================================
:: ETAPA 1: CONFIGURAR O UWF (REQUER REINÍCIO APÓS AS ALTERAÇÕES)
:: Execute este script UMA VEZ.
:: =========================================================

:: 1) Proteger a unidade C: contra alterações permanentes
uwfmgr.exe volume protect C:

:: 2) Configurar Overlay (Usando DISCO em vez de RAM)
:: Recomendado para HD de 500GB → 50GB de overlay
uwfmgr.exe overlay set-type DISK
uwfmgr.exe overlay set-size 51200

:: 3) Definir Alertas (80% e 90% de 50GB)
uwfmgr.exe overlay set-warningthreshold 40960
uwfmgr.exe overlay set-criticalthreshold 46080

:: 4) Exclusões Essenciais

:: Relógio/Fuso horário
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones"
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"

:: Windows Defender
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender"
uwfmgr.exe file add-exclusion "C:\Program Files\Windows Defender"
uwfmgr.exe file add-exclusion "C:\ProgramData\Microsoft\Windows Defender"
uwfmgr.exe file add-exclusion "C:\Windows\Windowsupdate.log"
uwfmgr.exe file add-exclusion "C:\Windows\Temp\MpCMDRun.log"
uwfmgr.exe file add-exclusion "%ALLUSERSPROFILE%\Microsoft\Network\Downloader"

:: Opcional: Kaspersky
:: uwfmgr.exe file add-exclusion "C:\Program Files (x86)\Kaspersky Lab"

:: Opcional: salvar documentos
:: CUIDADO: grava diretamente no disco permanente
:: uwfmgr.exe file add-exclusion "C:\Users\Public"
:: uwfmgr.exe file add-exclusion "C:\Users\Public\Documents"

:: 

:: =========================================================
:: FINALIZAR: Exibir status e REINICIAR
:: =========================================================

uwfmgr.exe get-config

echo.
echo =========================================================
echo UWF CONFIGURADO PARA USAR OVERLAY NO HD/SSD (50GB)
echo AS ALTERACOES ENTRARAO EM VIGOR APOS REINICIAR
echo =========================================================

pause

