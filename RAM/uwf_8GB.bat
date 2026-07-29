:: =========================================================
:: ETAPA 1: CONFIGURAR O UWF (REQUER REINÍCIO APÓS AS ALTERAÇÕES)
:: Execute este script UMA VEZ.
:: =========================================================

:: 1) Proteger a unidade C: contra alterações permanentes
uwfmgr.exe volume protect C:

:: 2) Configurar Overlay (Usando RAM para melhor performance)
:: Se a máquina tiver 8GB de RAM ou mais. 4096 = 4 GB.
uwfmgr.exe overlay set-type RAM
uwfmgr.exe overlay set-size 4096

:: 3) Definir Alertas (80% e 90% de 4096 MB)
uwfmgr overlay set-warningthreshold 3277
uwfmgr overlay set-criticalthreshold 3686

:: 4) Exclusões Essenciais
:: Relógio/Fuso horário
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones"
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"

:: Windows Defender (Exclusões completas)
uwfmgr.exe registry add-exclusion "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender"
uwfmgr.exe file add-exclusion "C:\Program Files\Windows Defender"
uwfmgr.exe file add-exclusion "C:\ProgramData\Microsoft\Windows Defender"
uwfmgr.exe file add-exclusion "C:\Windows\Windowsupdate.log"
uwfmgr.exe file add-exclusion "C:\Windows\Temp\MpCMDRun.log"
uwfmgr.exe file add-exclusion "%ALLUSERSPROFILE%\Microsoft\Network\Downloader"

:: Opcional: Kaspersky (Comente se não estiver instalado)
:: uwfmgr.exe file add-exclusion "C:\Program Files (x86)\Kaspersky Lab"

:: Opcional: Se for necessário salvar documentos (CUIDADO: consome espaço no disco original)
:: uwfmgr.exe file add-exclusion "C:\Users\Public" 
:: uwfmgr.exe file add-exclusion "C:\Users\Public\Documents"

:: 5) Ativar o filtro UWF
uwfmgr.exe filter enable

:: =========================================================
:: FINALIZAR: Exibir status e REINICIAR
:: =========================================================
uwfmgr.exe get-config
echo.
echo =========================================================
echo AS ALTERAÇÕES ENTRARÃO EM VIGOR APÓS A REINICIALIZAÇÃO!
echo =========================================================
pause

shutdown /r /t 0
