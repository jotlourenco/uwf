:: =========================================================
:: ATIVAÇÃO E CONFIGURAÇÃO DO UWF - OTIMIZADO PARA 16GB RAM
:: Execute como ADMINISTRADOR e com UWF inicialmente DESATIVADO.
:: =========================================================

:: 1) Proteger a unidade C:
uwfmgr.exe volume protect C:

:: 2) Configurar Overlay na RAM (Melhor Performance)
:: Definindo o tamanho do Overlay para 8 GB (8192 MB), utilizando a RAM abundante.
uwfmgr.exe overlay set-type RAM
uwfmgr.exe overlay set-size 8192

:: 3) Definir Alertas (Baseado em 8192 MB)
:: 80% de 8192 MB (6553 MB) - Aviso de que o overlay está enchendo.
uwfmgr overlay set-warningthreshold 6553
:: 90% de 8192 MB (7372 MB) - Limite crítico.
uwfmgr overlay set-criticalthreshold 7372

:: 4) Exclusões Essenciais (Permite a escrita permanente nestes locais)
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

:: Opcional: Se for necessário salvar documentos para todos os usuários (CUIDADO: consome espaço no disco original)
:: uwfmgr.exe file add-exclusion "C:\Users\Public" 
:: uwfmgr.exe file add-exclusion "C:\Users\Public\Documents"

:: 5) Ativar o filtro UWF
uwfmgr.exe filter enable

:: =========================================================
:: FINALIZAR: Exibir status do UWF e Reiniciar
:: =========================================================
uwfmgr.exe get-config
echo.
echo =========================================================
echo O UWF FOI CONFIGURADO (8GB RAM Overlay) E SERÁ ATIVADO APÓS O REINÍCIO!
echo Pressione qualquer tecla para continuar e reiniciar.
echo =========================================================
pause

shutdown /r /t 0
