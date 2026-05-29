@echo off
chcp 65001 >nul
set "INSTALL_DIR=%LOCALAPPDATA%\AutoReleaseTool"
del "%USERPROFILE%\Desktop\AutoReleaseTool.lnk" 2>nul
rmdir /S /Q "%INSTALL_DIR%" 2>nul
echo Uninstalled.
pause