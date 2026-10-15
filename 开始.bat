@echo off
chcp 65001 >nul

set "APP_DIR=%~dp0Edge"
set "HOST_DIR=%~dp0AppHost"
set "JUNCTION=%HOST_DIR%\Microsoft\Edge\Application"
set "EDGE_EXE="
set "VERSION_DIR="

for /d %%d in ("%APP_DIR%\*") do (
    if exist "%%d\msedge.exe" (
        set "EDGE_EXE=%%d\msedge.exe"
        set "VERSION_DIR=%%d"
        goto :found
    )
)

echo 未找到版本目录中的 msedge.exe
pause
exit /b 1

:found
rem Copy msedge.exe / version.dll to the Edge root (junction top):
rem the shortcut starts the exe at the junction top, so version.dll and
rem chrome++.ini (junction target = Edge root) must sit next to it.
if not exist "%APP_DIR%\msedge.exe" copy /y "%EDGE_EXE%" "%APP_DIR%\msedge.exe" >nul
if not exist "%APP_DIR%\version.dll" copy /y "%VERSION_DIR%\version.dll" "%APP_DIR%\version.dll" >nul

rem Generate the Edge-root chrome++.ini (UTF-16) from the version-dir copy:
rem data_dir/cache_dir go from two levels up (version dir) to four (junction top).
if not exist "%APP_DIR%\chrome++.ini" (
    if not exist "%VERSION_DIR%\chrome++.ini" (
        echo 未找到 %VERSION_DIR%\chrome++.ini
        pause
        exit /b 1
    )
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$t=[IO.File]::ReadAllText($env:VERSION_DIR + '\chrome++.ini'); $t=$t.Replace('data_dir=%%app%%\..\..\Data','data_dir=%%app%%\..\..\..\..\Data').Replace('cache_dir=%%app%%\..\..\Cache','cache_dir=%%app%%\..\..\..\..\Cache'); [IO.File]::WriteAllText($env:APP_DIR + '\chrome++.ini', $t, [Text.Encoding]::Unicode)"
)

rem Rebuild the junction every run (absolute target breaks after moving the folder).
if exist "%JUNCTION%\" rmdir "%JUNCTION%"
mkdir "%HOST_DIR%\Microsoft\Edge" 2>nul
mklink /J "%JUNCTION%" "%APP_DIR%" >nul
if not exist "%JUNCTION%\msedge.exe" (
    echo 路径映射失败
    pause
    exit /b 1
)

rem Shortcut targets the version-agnostic entry at the junction top; the path
rem shape then matches an official install and Edge identifies as Stable.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=New-Object -ComObject WScript.Shell; $l=$s.CreateShortcut('%~dp0Edge.lnk'); $l.TargetPath='%JUNCTION%\msedge.exe'; $l.Arguments=''; $l.WorkingDirectory='%~dp0'; $l.IconLocation='%JUNCTION%\msedge.exe,0'; $l.Save()"

if exist "%~dp0Edge.lnk" (
    echo 快捷方式创建成功
    echo 指向: %JUNCTION%\msedge.exe
    echo 通过该快捷方式启动 Edge 即可正常设置默认浏览器
    exit /b 0
) else (
    echo 快捷方式创建失败
    pause
    exit /b 1
)
