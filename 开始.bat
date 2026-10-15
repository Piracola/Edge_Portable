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
rem 把 msedge.exe 与 version.dll 复制到 Edge 根目录（junction 顶层）：
rem 快捷方式经 AppHost 启动时 exe 位于 junction 顶层，相邻的 version.dll
rem 与 chrome++.ini（junction 目标 Edge 根目录）才能被找到。
if not exist "%APP_DIR%\msedge.exe" copy /y "%EDGE_EXE%" "%APP_DIR%\msedge.exe" >nul
if not exist "%APP_DIR%\version.dll" copy /y "%VERSION_DIR%\version.dll" "%APP_DIR%\version.dll" >nul

rem 生成 Edge 根目录的 chrome++.ini（UTF-16）：以版本目录里的 ini 为底稿，
rem data_dir/cache_dir 从版本目录形态（上跳两级）改为 junction 顶层形态（上跳四级）。
if not exist "%APP_DIR%\chrome++.ini" (
    if not exist "%VERSION_DIR%\chrome++.ini" (
        echo 未找到 %VERSION_DIR%\chrome++.ini
        pause
        exit /b 1
    )
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$t=[IO.File]::ReadAllText($env:VERSION_DIR + '\chrome++.ini'); $t=$t.Replace('data_dir=%%app%%\..\..\Data','data_dir=%%app%%\..\..\..\..\Data').Replace('cache_dir=%%app%%\..\..\Cache','cache_dir=%%app%%\..\..\..\..\Cache'); [IO.File]::WriteAllText($env:APP_DIR + '\chrome++.ini', $t, [Text.Encoding]::Unicode)"
)

rem 每次运行重建 junction（目标是绝对路径，文件夹搬动后即失效，重建即恢复）。
if exist "%JUNCTION%\" rmdir "%JUNCTION%"
mkdir "%HOST_DIR%\Microsoft\Edge" 2>nul
mklink /J "%JUNCTION%" "%APP_DIR%" >nul
if not exist "%JUNCTION%\msedge.exe" (
    echo 路径映射失败
    pause
    exit /b 1
)

rem 快捷方式指向 junction 顶层的版本无关入口（路径形态与官方安装一致），
rem Edge 据此把自己识别为 Stable 渠道，默认浏览器设置页面才可用。
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
