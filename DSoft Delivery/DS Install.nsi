; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "DSoft Delivery"
!define PRODUCT_VERSION "1.2"
!define PRODUCT_PUBLISHER "DSoft Sistemas Ltda."
!define PRODUCT_WEB_SITE "http://sites.google.com/site/dsoftsistemas"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\unins000.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "bin\Licenca.txt"
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\DSoft_Delivery.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "PortugueseBR"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "DS Install.exe"
InstallDir "C:\DSoft\DSoft Delivery"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "Se��oPrincipal" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "bin\Release\pizza.png"
  File "bin\Release\Npgsql.xml"
  File "bin\Release\Npgsql.dll"
  File "bin\Release\Mono.Security.dll"
  File "bin\Release\dsoft_login12.png"
  File "bin\Release\dsoft_login.png"
  File "bin\Release\dsoft_delivery12.png"
  File "bin\Release\dsoft_delivery.png"
  SetOverwrite off
  File "bin\Release\dsoft.ini"
  SetOverwrite ifnewer
  File "bin\Release\DSoft Delivery.vshost.exe.manifest"
  SetOverwrite off
  File "bin\Release\DSoft Delivery.vshost.exe.config"
  SetOverwrite ifnewer
  File "bin\Release\DSoft Delivery.vshost.exe"
  File "bin\Release\DSoft Delivery.vshost.application"
  File "bin\Release\DSoft Delivery.pdb"
  File "bin\Release\DSoft Delivery.exe.manifest"
  SetOverwrite off
  File "bin\Release\DSoft Delivery.exe.config"
  SetOverwrite ifnewer
  File "bin\Release\DSoft Delivery.exe"
  CreateDirectory "$SMPROGRAMS\DSoft Delivery"
  CreateShortCut "$SMPROGRAMS\DSoft Delivery\DSoft Delivery.lnk" "$INSTDIR\DSoft Delivery.exe"
  CreateShortCut "$DESKTOP\DSoft Delivery.lnk" "$INSTDIR\DSoft Delivery.exe"
  File "bin\Release\DSoft Delivery.application"
  File "bin\Release\DSKey.pdb"
  File "bin\Release\DSKey.dll"
  CreateDirectory "C:\DSoft\Key"
  CreateDirectory "C:\DSoft\Log"
  CreateDirectory "C:\DSoft\Backup"
  File "C:\DSoft\Ferramentas\dotNetFx40_Full_setup.exe"
SectionEnd

!define NETVersion "4.0"
!define NETInstaller "C:\DSoft\Ferramentas\dotNetFx40_Full_setup.exe"
Section "MS .NET Framework v${NETVersion}" SecFramework
  IfFileExists "$WINDIR\Microsoft.NET\Framework\v${NETVersion}" NETFrameworkInstalled 0
  File /oname=$TEMP\${NETInstaller} ${NETInstaller}

  DetailPrint "Iniciando instala��o do Microsoft .NET Framework v${NETVersion}..."
  ExecWait "$TEMP\${NETInstaller}"
  Return

  NETFrameworkInstalled:
  DetailPrint "Microsoft .NET Framework j� instalado!"

SectionEnd

!define PostgreSqlVersion "9.2"
!define PostgreSqlInstaller "C:\DSoft\Ferramentas\postgresql-9.2.2-1-windows.exe"
Section "PostgreSql ${PostgreSqlVersion}"
        IfFileExists "$PROGRAMFILES\PostgreSql\${PostgreSqlVersion}\bin\psql.exe" PostgreSqlInstalled
        
        DetailPrint "Iniciando instala��o do PostgreSql ${PostgreSqlVersion}..."
        IfFileExists ${PostgreSqlInstaller} success

        NSISdl::download http://get.enterprisedb.com/postgresql/postgresql-9.2.2-1-windows.exe ${PostgreSqlInstaller}
        Pop $0
        StrCmp $0 success success
               SetDetailsView show
               DetailPrint "Falha no download: $0"
               MessageBox MB_OK "Falha no download: $0"
               Abort
        success:
                ExecWait "${PostgreSqlInstaller}"
                ;Delete ${PostgreSqlInstaller}
        
        Return
        
        PostgreSqlInstalled:
        DetailPrint "PostgreSql ${PostgreSqlVersion} j� instalado!"
        
        ; Criar usu�rio
        

SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\DSoft Delivery\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\unins000.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\unins000.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) foi removido com sucesso do seu computador."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Tem certeza que quer remover completamente $(^Name) e todos os seus componentes?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\DSKey.dll"
  Delete "$INSTDIR\DSKey.pdb"
  Delete "$INSTDIR\DSoft Delivery.application"
  Delete "$INSTDIR\DSoft Delivery.exe"
  Delete "$INSTDIR\DSoft Delivery.exe.config"
  Delete "$INSTDIR\DSoft Delivery.exe.manifest"
  Delete "$INSTDIR\DSoft Delivery.pdb"
  Delete "$INSTDIR\DSoft Delivery.vshost.application"
  Delete "$INSTDIR\DSoft Delivery.vshost.exe"
  Delete "$INSTDIR\DSoft Delivery.vshost.exe.config"
  Delete "$INSTDIR\DSoft Delivery.vshost.exe.manifest"
  Delete "$INSTDIR\dsoft.ini"
  Delete "$INSTDIR\dsoft_delivery.png"
  Delete "$INSTDIR\dsoft_delivery12.png"
  Delete "$INSTDIR\dsoft_login.png"
  Delete "$INSTDIR\dsoft_login12.png"
  Delete "$INSTDIR\Mono.Security.dll"
  Delete "$INSTDIR\Npgsql.dll"
  Delete "$INSTDIR\Npgsql.xml"
  Delete "$INSTDIR\pizza.png"

  Delete "$SMPROGRAMS\DSoft Delivery\Uninstall.lnk"
  Delete "$SMPROGRAMS\DSoft Delivery\Website.lnk"
  Delete "$DESKTOP\DSoft Delivery.lnk"
  Delete "$SMPROGRAMS\DSoft Delivery\DSoft Delivery.lnk"

  RMDir "$SMPROGRAMS\DSoft Delivery"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd