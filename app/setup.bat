@echo off
chcp 65001 >nul
set "INSTALL_DIR=%LOCALAPPDATA%\AutoReleaseTool"

echo Installing AutoReleaseTool...
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

xcopy "%~dp0*" "%INSTALL_DIR%\" /E /Y /I >nul

powershell -NoProfile -ExecutionPolicy Bypass -Command "$desktop=[Environment]::GetFolderPath('Desktop'); $s=(New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path $desktop 'AutoReleaseTool.lnk')); $s.TargetPath='%INSTALL_DIR%\run.bat'; $s.WorkingDirectory='%INSTALL_DIR%'; $s.Save()"

echo.
echo Installed successfully.
echo Desktop shortcut: AutoReleaseTool
echo.
pause